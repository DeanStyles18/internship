import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standups/Popular_videos_slider.dart';
import 'controller/dash_controller.dart';
import 'trending_shorts_slider.dart';
import 'trending_slider.dart';
import 'recently_watched_slider.dart';
import 'artist_slider.dart';
import 'category_slider.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<DashController>().getPublicPlayListHome(page: 1);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<DashController>(
                  builder: (dashController) => TrendingSlider(dashController)),
              SizedBox(height: 16),
              RecentlyWatchedSlider(),
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: ArtistSlider(),
          ),
          SizedBox(height: 20),
          PopularVideosSlider(),
          SizedBox(height: 16),
          CategoriesSlider(),
          SizedBox(height: 16),
          TrendingShortsSlider(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
