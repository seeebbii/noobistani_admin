
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/model/userModel.dart';
import 'package:noobistani_admin/model/videoModel.dart';
import 'package:video_player/video_player.dart';

class Database{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<bool> createUserInDatabase(UserModel user) async{
    try{
      await _firestore.collection('users').doc(user.id).set({
        'uid' : user.id,
        'name' : user.name,
        'email' : user.email,
        'imageUrl' : user.imageUrl,
        'createdAt' : user.createdAt,
        'bio' : user.bio,
      });
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<bool> isNewUser(User? user) async {
    QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: user!.email)
        .get();
    final List<DocumentSnapshot> docs = result.docs;
    return docs.length == 0 ? true : false;
  }

  Future<UserModel> getUser(String uid) async {
    try{
      DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  void uploadVideo(UserModel user, File file, String caption) async{
    Timestamp time = Timestamp.now();
    final ref =  _firebaseStorage.ref().child('user_videos').child('$time.mp4');
    String downloadableUrl = '';
    try{
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        print(event.bytesTransferred);
      });
      downloadableUrl = await (await uploadTask).ref.getDownloadURL();
      print(downloadableUrl);
    }catch(e){
      print(e.toString());
    }
    // PUBLIC VIDEO UPLOADS
    try{
      await _firestore.collection('uploaded_videos').doc().set({
        'uid' : user.id,
        'name' : user.name,
        'email' : user.email,
        'imageUrl' : user.imageUrl,
        'createdAt' : time,
        'videoUrl' : downloadableUrl,
        'caption' : caption
        // 'views' : 0,
        // 'comments': []
      });
    }catch(e){
      print(e.toString());
    }
    // EACH USERS RECORD
    try{
      await _firestore.collection('users').doc(user.id).collection('uploaded_videos').doc().set({
        "videoUrl" : downloadableUrl,
        'caption' : caption,
        'createdAt' : time,
      });
    }catch(e){
      print(e.toString());
    }
  }

  Stream<List<VideoModel>> getVideos(){
    return _firestore.collection('uploaded_videos').orderBy('createdAt', descending: true).snapshots().map((event){
      List<VideoModel> retVal = <VideoModel>[];
      event.docs.forEach((element) {
        retVal.add(VideoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<VideoModel>> getUserVideos(String? uid){
    return _firestore.collection('users').doc(uid).collection("uploaded_videos").orderBy('createdAt', descending: true).snapshots().map((event){
      List<VideoModel> retVal = <VideoModel>[];
      event.docs.forEach((element) {
        retVal.add(VideoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<VideoPlayerController>> getVideoUrl(){
    return _firestore.collection('uploaded_videos').orderBy('createdAt', descending: true).snapshots().map((event){
      List<VideoPlayerController> retVal = <VideoPlayerController>[];
      event.docs.forEach((element) {
        retVal.add(VideoPlayerController.network(VideoModel.fromDocumentSnapshot(element).videoUrl)..initialize()..setLooping(true));
      });
      return retVal;
    });
  }

}