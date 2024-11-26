import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/api_url.dart';

class DashRepo{

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  DashRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getPublicPlayList({int? page,String? videoId}) async {
    return await apiClient.getData(
        "${ApiUrls.publicPlayList}?shortVideos=true&pageNo=$page&itemPerPage=30");
  }
  Future<Response> getPublicPlayListHome({int? page,String? videoId}) async {
    return await apiClient.getData(
        "${ApiUrls.publicPlayList}?shortVideos=false&pageNo=$page&itemPerPage=30");
  }

  Future<Response> getArtist({int? page,int? item}) async {
    return await apiClient.getData(
        "${ApiUrls.artistListURL}?pageNo=$page&itemPerPage=$item");
  }

  Future<Response> getArtistData({int? id}) async {
    return await apiClient.getData(
        "${ApiUrls.getArtistDataURL}?artist_id=$id&&pageNo=1&itemPerPage=1");
  }
  Future<Response> getVideoDetails({String? videoLink}) async {
    return await apiClient.getData(
        "${ApiUrls.getVideoDetailsURL}$videoLink");
  }
}