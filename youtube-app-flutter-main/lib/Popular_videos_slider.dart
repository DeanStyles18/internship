import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:standups/contants/app_contants.dart';
import 'api_service.dart';
import 'models/videos_model.dart' as videos;
import 'video_detail.dart';

class PopularVideosSlider extends StatefulWidget {
  @override
  _PopularVideosSliderState createState() => _PopularVideosSliderState();
}

class _PopularVideosSliderState extends State<PopularVideosSlider> {
  late ApiService apiService;
  List<videos.Data> popularVideosList = [];
  int page = 1;
  final int limit = 10; 
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(
        'https://devapi.standups7.com/api/v1/playlist/get-public-playlist?shortVideos=false&pageNo=1&itemPerPage=500');
    _fetchPopularVideos();
  }

  Future<void> _fetchPopularVideos() async {
    try {
      final response = await apiService.fetchAllVideos(page, limit);
      if (response != null && response.data != null) {
        setState(() {
          popularVideosList = response.data!;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching popular videos: $e');
    }
  }

  void onVideoTapped(videos.Data video) {
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
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Popular Videos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: popularVideosList.length,

                    controller: PageController(viewportFraction: 1),
                    itemBuilder: (context, index) {

                      final video = popularVideosList[index];
                      return GestureDetector(
                        onTap: () =>
                            onVideoTapped(video),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: AppContents.placeHolderImage(imageURl: video.videoMediumImg,height: 200,width: double.infinity,rightRadius: 5,bottomRadius: 5,bottomRightRidus: 5,topRadius: 5),
                            ),
                            Align(
                              alignment:Alignment.bottomCenter,
                              child: Container(
                                width:double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  color: Colors.black.withOpacity(0.4)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                                  child: Text(video.videoTitle!,
                                    textAlign:TextAlign.start,
                                    style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
