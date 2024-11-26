import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'api_service.dart';
import 'contants/app_contants.dart';
import 'models/videos_model.dart' as videos;
import 'artist_models.dart' as artist_models;
import 'video_detail.dart';
import 'navigation_bar.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late ApiService apiService;
  List<videos.Data> videosList = [];
  Map<int, artist_models.Data> artistMap = {};
  int page = 1;
  final int limit = 20;
  bool isLoadingMore = false;
  bool hasMore = true;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  videos.Data? selectedVideo;
  final ScrollController _scrollController = ScrollController();

  final List<Color> gradientColors = [
    Color(0xFFE51E31), // Bright Red
    Color(0xFF158A08), // Bright Green
    Color(0xFF0C72EE), // Bright Blue
    Color(0xFFFF0090), // Magenta
    Color(0xFFDB148B), // Similar Magenta
    Color(0xFFB85D06), // Brown
    Color(0xFFE8125C), // Pink
    Color(0xFF951118), // Dark Maroon
    Color(0xFF1E3264), // Dark Blue
    Color(0xFFA56752), // Beige
  ];

  @override
  void initState() {
    super.initState();
    apiService = ApiService(
      'https://prodapi.standups7.com/api/v1/artist/get-public-artist?pageNo=1&itemPerPage=500',
    );
    _fetchArtists();

    apiService = ApiService(
      'https://prodapi.standups7.com/api/v1/playlist/get-public-playlist?shortVideos=false&pageNo=1&itemPerPage=500',
    );

    _fetchVideos();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchVideos(loadMore: true);
      }
    });
  }

  Future<void> _fetchArtists() async {
    try {
      final artistResponse = await apiService.fetchArtistData();
      if (artistResponse.data != null) {
        setState(() {
          for (var artist in artistResponse.data!) {
            artistMap[artist.artistId!] = artist;
          }
        });
      }
    } catch (e) {
      print('Error fetching artists: $e');
    }
  }

  Future<void> _fetchVideos({bool loadMore = false}) async {
    if (isLoadingMore || !hasMore) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final response = await apiService.fetchAllVideos(page, limit);
      if (response != null && response.data != null) {
        final newVideos = response.data!;
        setState(() {
          if (searchQuery.isEmpty) {
            videosList.addAll(newVideos);
          } else {
            videosList.addAll(newVideos.where((video) => video.videoTitle!
                .toLowerCase()
                .contains(searchQuery.toLowerCase())));
          }
          hasMore = newVideos.length == limit;
          page++;
        });
      }
    } catch (e) {
      print('Error fetching videos: $e');
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchController.clear();
        searchQuery = '';
        _fetchVideos(); // Refresh videos list when search is cleared
      }
    });
  }

  void onSearchSubmitted(String query) {
    setState(() {
      searchQuery = query;
      _fetchVideos(); // Trigger search
    });
  }

  void onVideoTapped(videos.Data video) {
    setState(() {
      if (selectedVideo == video) {
        selectedVideo = null;
      } else {
        selectedVideo = video;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VideoDetailPage(finalVideoPageId: video.videosFinalDataId!.toString()),
        ),
      );
    });
  }

  void onVideoDoubleTapped(videos.Data video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VideoDetailPage(finalVideoPageId: video.videosFinalDataId!.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredVideos = videosList.where((video) {
      return searchQuery.isEmpty ||
          (video.videoTitle
                  ?.toLowerCase()
                  .contains(searchQuery.toLowerCase()) ??
              false);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title:AppContents.AppBarImage(),
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(169, 4, 20, 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                isSearching ? Icons.close : Icons.search,
                color: Colors.white,
              ),
            ),
            onPressed: toggleSearch,
          ),
        ],
        bottom: isSearching
            ? PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                      _fetchVideos(); // Trigger search
                    },
                    onSubmitted: onSearchSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[800]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(169, 4, 20, 1), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[800]!),
                      ),
                      fillColor: Colors.grey[800],
                      filled: true,
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : null,
      ),
      body: Container(
        color: Colors.black, // Full black background
        child: ListView.builder(
          controller: _scrollController,
          itemCount: filteredVideos.length,
          itemBuilder: (context, index) {
            final video = filteredVideos[index];
            final artist = artistMap[video.artistId];
            final gradientColor = gradientColors[index %
                gradientColors.length]; // Apply different color for each card

            return AppContents.videoWidget(context,video.videosFinalDataId.toString(),gradientColor,video.videoMediumImg.toString(),video.videoTitle.toString(),video.videoDuration.toString(),(){setState(() {
              if (selectedVideo == video) {
                selectedVideo = null;
              } else {
                selectedVideo = video;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoDetailPage(finalVideoPageId: video.videosFinalDataId!.toString()),
                ),
              );
            });});

              /*GestureDetector(
                onTap: () => onVideoTapped(video),
                onDoubleTap: () => onVideoDoubleTapped(video),
                child: Card(
                  elevation:
                      4, // Optional: Add elevation if you want a shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black, // Black background for the card
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [gradientColor.withOpacity(1.0), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 1.0],
                      ),
                      border: Border.all(
                        color:
                            gradientColor, // Border color matching the gradient
                        width: 1.0, // Width of the border
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: video.videoMediumImg ?? '',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  video.videoDuration ?? '0:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            artist != null
                                ? CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        artist.artistLargeImg ?? ''),
                                    radius: 24,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 24,
                                  ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    video.videoTitle ?? 'No title',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // Removed SizedBox with height 0
                                  // Just ensuring there's a spacing for aesthetics
                                  SizedBox(height: 4), // Optional spacing
                                  Text(
                                    // This could be the artist's name or similar information
                                    artist?.artistName ?? 'Unknown Artist',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))*/;
          },
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(currentRoute: '/video'),
    );
  }
}
