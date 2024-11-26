

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:standups/api/api_url.dart';
import '../api/api_client.dart';
import '../controller/dash_controller.dart';
import 'dash_repo.dart';



Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiUrls.baseURl, sharedPreferences: Get.find()));
  Get.lazyPut(() => DashController(Repo: Get.find()));




    Get.lazyPut(() => DashRepo( sharedPreferences: Get.find(), apiClient: Get.find()));





/*  Get.lazyPut(() => sharedPreferences);


  // Repository
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => FeedRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => PageRepo(apiClient: Get.find()));
  Get.lazyPut(() => SearchRepo(apiClient: Get.find()));
  Get.lazyPut(() => ParkRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => PostRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find()));

  // Controller

  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PageController2(authRepo: Get.find()));
  Get.lazyPut(() => FeedController(authRepo: Get.find()));
  Get.lazyPut(() => ProfileController(authRepo: Get.find()));
  Get.lazyPut(() => SearchControllerData(authRepo: Get.find()));
  Get.lazyPut(() => PostController(authRepo: Get.find()));
  Get.lazyPut(() => DashBoardController(authRepo: Get.find()));
  Get.lazyPut(() => ParkController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(authRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));*/


  // Retrieving localized data

}