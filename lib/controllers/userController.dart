import 'package:get/get.dart';
import 'package:noobistani_admin/model/userModel.dart';
import 'package:noobistani_admin/model/videoModel.dart';
import 'package:noobistani_admin/services/Database.dart';
import 'package:video_player/video_player.dart';

class UserController extends GetxController {

  var currentUser = UserModel().obs;
  var listOfVideos = <VideoModel>[].obs;
  var listOfControllers = <VideoPlayerController>[].obs;
  var listOfUserVideos = <VideoModel>[].obs;


  void initializeData(){
    listOfVideos.bindStream(Database().getVideos());
    listOfControllers.bindStream(Database().getVideoUrl());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    initializeData();
    super.onInit();
  }

}