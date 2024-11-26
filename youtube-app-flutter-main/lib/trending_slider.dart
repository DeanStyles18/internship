import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:standups/contants/app_colors.dart';
import 'package:standups/contants/app_contants.dart';
import 'package:standups/controller/dash_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'video_detail.dart';
import 'artist_detail.dart';

class TrendingSlider extends StatefulWidget {
  DashController dashController;
  TrendingSlider(this.dashController);

  @override
  _TrendingSliderState createState() => _TrendingSliderState();
}

class _TrendingSliderState extends State<TrendingSlider> {
  late PageController _pageController;
  // List<Trending.Data> _videos = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onPageChanged);
    // _loadMoreVideos();
  }

  void _onPageChanged() {
    if (_pageController.page ==
            widget.dashController.videoListResponse!.data!.length - 1 &&
        _hasMore &&
        !_isLoading) {
      // _loadMoreVideos();
    }
  }

  // Future<void> _loadMoreVideos() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     // Make the API call directly using http
  //     final response = await http.get(Uri.parse(
  //         'https://prodapi.standups7.com/api/v1/playlist/get-trending-types?trending_type=VIDEOS&pageNo=$_currentPage&itemPerPage=10'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       if (data['data'] != null && data['data'].isNotEmpty) {
  //         setState(() {
  //           _videos.addAll(
  //             (data['data'] as List)
  //                 .map((videoData) => Trending.Data.fromJson(videoData))
  //                 .toList(),
  //           );
  //           _currentPage++;
  //         });
  //       } else {
  //         setState(() {
  //           _hasMore = false;
  //         });
  //       }
  //     } else {
  //       print('Failed to load trending videos');
  //     }
  //   } catch (e) {
  //     print('Error loading videos: $e');
  //   }
  //
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: widget.dashController.videoListResponse != null &&
              widget.dashController.videoListResponse!.data != null &&
              widget.dashController.videoListResponse!.data!.isNotEmpty
          ? PageView.builder(
              controller: _pageController,
              itemCount: widget.dashController.videoListResponse != null &&
                      widget.dashController.videoListResponse!.data != null
                  ? widget.dashController.videoListResponse!.data!.length
                  : 0,
              scrollDirection: Axis.horizontal, // Make sure it's horizontal
              physics: BouncingScrollPhysics(), // Adds smooth bouncing effect
              itemBuilder: (context, index) {
                final video =
                    widget.dashController.videoListResponse!.data![index];
                final videoId =
                    YoutubePlayer.convertUrlToId(video.videoLink ?? '') ?? '';

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AppContents.placeHolderImage(
                          imageURl: video.videoLargeImg,
                          height: 350,
                          width: double.infinity,
                          topRadius: 8,
                          rightRadius: 8,
                          bottomRadius: 8,
                          bottomRightRidus: 8)

                      /*YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoId,

                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: true,
                      hideControls: true,
                      controlsVisibleAtStart: true
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Color.fromARGB(255, 255, 0, 0),
                  progressColors: ProgressBarColors(
                    playedColor: Color.fromARGB(255, 255, 0, 0),
                    handleColor: const Color.fromARGB(255, 255, 64, 64),
                  ),
                )*/
                      ,
                    ),
                    /*Container(
                color: Colors.black.withOpacity(0.2),
              ),*/
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ArtistDetailsPage(
                                                    artistId: int.parse(video
                                                        .artistId!
                                                        .toString()),
                                                    data: null,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              video.artistName ??
                                                  'Unknown Artist',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            "${video.videoTitle}",
                                            maxLines: 2,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SvgPicture.asset(
                                            'assets/icon.svg',
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoDetailPage(
                                                finalVideoPageId: video
                                                    .videosFinalDataId!
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryColor,
                                            ),
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                            )),
                                      ))
                                ],
                              ),
                            ),

                            /*Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoDetailPage(
                                  finalVideoPageId: video.videosFinalDataId!,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(169, 4, 20, 1),
                            padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'WATCH NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
