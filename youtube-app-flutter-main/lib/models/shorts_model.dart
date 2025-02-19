import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Autogenerated {
  String? message;
  int? totalRecords;
  int? currentRecords;
  List<Data>? data;

  Autogenerated({
    this.message,
    this.totalRecords,
    this.currentRecords,
    this.data,
  });

  Autogenerated.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalRecords = json['totalRecords'];
    currentRecords = json['currentRecords'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = this.message;
    data['totalRecords'] = this.totalRecords;
    data['currentRecords'] = this.currentRecords;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? videosFinalDataId; // Page ID
  int? artistId; // Artist ID
  String? artistName; // Artist Name
  String? videoTitle; // Title
  String? videoDescription; // Video Description
  String? videoLink; // Video Link
  String? videoMaxresImg; // Max Res Image
  String? videoMediumImg; // Medium Image
  String? videoDuration; // Video Duration
  String? videoPublishDate; // Video Publish Date
  YoutubePlayerController? controller;

  Data({
    this.videosFinalDataId,
    this.artistId,
    this.artistName,
    this.videoTitle,
    this.videoDescription,
    this.videoLink,
    this.videoMaxresImg,
    this.videoMediumImg,
    this.videoDuration,
    this.videoPublishDate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    videosFinalDataId = json['videos_final_data_id'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
    videoTitle = json['video_title'];
    videoDescription = json['video_description'];
    videoLink = json['video_link'];
    videoMaxresImg = json['video_maxres_img'];
    videoMediumImg = json['video_medium_img'];
    videoDuration = json['video_duration'];
    videoPublishDate = json['video_publish_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['videos_final_data_id'] = this.videosFinalDataId;
    data['artist_id'] = this.artistId;
    data['artist_name'] = this.artistName;
    data['video_title'] = this.videoTitle;
    data['video_description'] = this.videoDescription;
    data['video_link'] = this.videoLink;
    data['video_maxres_img'] = this.videoMaxresImg;
    data['video_medium_img'] = this.videoMediumImg;
    data['video_duration'] = this.videoDuration;
    data['video_publish_date'] = this.videoPublishDate;
    return data;
  }

  Future<void> loadController() async {
    // Ensure the video link is not null
    if (videoLink != null) {
      // Print the complete YouTube video URL
      print("https://www.youtube.com/watch?v=$videoLink");

      // Extract the video ID from the URL
      String? videoId = YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=$videoLink");

      if (videoId != null) {
        // Initialize the YoutubePlayerController
        controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: true, // Auto-play the video
            mute: false, // Start with sound enabled
            loop: true, // Loop the video
          ),
        );
      } else {
        print("Failed to extract video ID from URL.");
      }
    } else {
      print("Video link is null");
    }
  }
}
