import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:standups/contants/app_colors.dart';
import 'package:standups/contants/app_contants.dart';
import 'dart:math';
import 'api_service.dart';
import 'artist_models.dart';
import 'controller/dash_controller.dart';
import 'navigation_bar.dart';
import 'artist_detail.dart';

class ArtistPage extends StatefulWidget {
  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final List<Data> _allArtists = []; 
  List<Data> _artists = []; 
  int _currentPage = 1;
  final int _itemsPerPage = 30;
  bool _hasMore = true;
  final List<Color> extractedColors = [
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_filterArtists);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<DashController>()
          .getArtistData(item: _itemsPerPage, page: _currentPage)
          .then((_) {
        if (mounted) {
          setState(() {
            _artists =
                Get.find<DashController>().artistListResponse!.data ?? [];
            _allArtists
                .addAll(_artists); 
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // Remove listener when the widget is disposed
    _searchController.removeListener(_filterArtists);
    _searchController.dispose();
    super.dispose();
  }

  // Filter artists based on search query
  void _filterArtists() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _artists = _allArtists.where((artist) {
        return artist.artistName?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  // Navigate to the artist detail page
  void _navigateToArtistDetails(int artistId, Data data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArtistDetailsPage(artistId: artistId, data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AppContents.AppBarImage(),
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFE51E31),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search artist',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFE51E31), width: 2.0), // Bright Red
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
            GetBuilder<DashController>(
              builder: (dashController) => GridView.builder(
                itemCount: _artists.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 160,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final randomColor =
                  extractedColors[Random().nextInt(extractedColors.length)];
                  final artist = _artists[index];

                  return  InkWell(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtistDetailsPage(artistId: int.parse(artist.artistId.toString()), data: artist),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 0.0),
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: randomColor,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: artist.artistLargeImg != null
                                  ? DecorationImage(
                                image: NetworkImage(artist.artistLargeImg!),
                                fit: BoxFit.cover,
                              )
                                  : null,
                              color: Colors.grey[800],
                            ),
                            child: artist.artistLargeImg == null
                                ? Icon(Icons.person, size: 35.0, color: Colors.white)
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            artist.artistName!,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            GetBuilder<DashController>(builder: (dashController) =>
                    dashController.artistListResponse!=null && dashController.artistListResponse!.data!=null ?
                   dashController.artistListResponse!.totalRecords! ==  _artists.length ? SizedBox(): InkWell(
                  onTap: (){
                    setState(() {
                      _currentPage++;
                    });
                    dashController
                        .getArtistData(item: _itemsPerPage, page: _currentPage);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white,width: 0.8)
                      ),
                      child: dashController.artistLoadMore ? SizedBox(height: 20,width: 20,child: Center(child: CircularProgressIndicator(strokeWidth: 0.6,color: Colors.white,),),):
                      Text("Load More",style: TextStyle(fontSize: 16,color: AppColors.primaryColor,fontWeight: FontWeight.bold),)),
                ):SizedBox())
            /*Expanded(
              child: *//*ArtistGrid(
                artists: _artists,
                onTap: _navigateToArtistDetails,
              ),*//*
            ),*/
        
        
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(currentRoute: '/artist'),
    );
  }
}

class ArtistGrid extends StatelessWidget {
  final List<Data> artists; 
  final Function(int, Data) onTap;

  const ArtistGrid({
    Key? key,
    required this.artists,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> extractedColors = [
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

    return GetBuilder<DashController>(
      builder: (dashController) => Column(
        children: [
          GridView.builder(
            itemCount: artists.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 160,
            ),
            itemBuilder: (BuildContext context, int index) {
              final randomColor =
                  extractedColors[Random().nextInt(extractedColors.length)];
              final artist = artists[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => onTap(artist.artistId!, artist),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0.0),
                      padding: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        color: randomColor,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: artist.artistLargeImg != null
                              ? DecorationImage(
                                  image: NetworkImage(artist.artistLargeImg!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey[800],
                        ),
                        child: artist.artistLargeImg == null
                            ? Icon(Icons.person, size: 35.0, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      artist.artistName!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // GetBuilder<DashController>(builder: (dashController) =>
          //     InkWell(
          //       onTap: (){
          //         setState(() {
          //           _currentPage++;
          //         });
          //         dashController
          //             .getArtistData(item: _itemsPerPage, page: _currentPage);
          //       },
          //       child: Container(
          //           padding: EdgeInsets.symmetric(horizontal: 15,vertical: 6),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(15),
          //               border: Border.all(color: Colors.white,width: 0.8)
          //           ),
          //           child: dashController.artistLoadMore ? SizedBox(height: 20,width: 20,child: Center(child: CircularProgressIndicator(strokeWidth: 0.6,color: Colors.white,),),):
          //           Text("Load More",style: TextStyle(fontSize: 16,color: AppColors.primaryColor,fontWeight: FontWeight.bold),)),
          //     ))
        ],
      ),
    );
  }
}
