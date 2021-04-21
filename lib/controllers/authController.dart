import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/model/userModel.dart';
import 'package:noobistani_admin/services/Database.dart';

class AuthController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final currentUser = FirebaseAuth.instance.currentUser.obs;


  @override
  void onInit() {
    currentUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void createUser(String email, String userName, String password) async{
    try{
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      UserModel _user = UserModel(id: _authResult.user!.uid, name: userName, email: email.trim(), imageUrl: "https://pbs.twimg.com/profile_images/1275457579078922240/BcW-3ekn.jpg", createdAt: Timestamp.now());
      if(await Database().createUserInDatabase(_user)){
        Get.put(UserController()).currentUser.value = _user;
        Get.back();
      }
    }catch(e){
      Get.snackbar("Error Creating Account",e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void loginWithGoogle() async{
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      return;
    }else{
      try{
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        _auth.signInWithCredential(credential);
        Future.delayed(Duration(milliseconds: 1000), () async{
          UserModel _user = UserModel(id: _auth.currentUser!.uid, name: _auth.currentUser!.displayName, email: _auth.currentUser!.email, imageUrl: _auth.currentUser!.photoURL, createdAt: Timestamp.now());

          if(await Database().createUserInDatabase(_user)){
            Get.put(UserController()).currentUser.value = _user;
          }
        });
      }catch(e){
        Get.snackbar("Error login Account",e.toString(), snackPosition: SnackPosition.BOTTOM);
      }

    }
  }

  void login(String email, String password) async {
    try{
      UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.put(UserController()).currentUser.value = await Database().getUser(authResult.user!.uid);
    }catch(e){
      Get.snackbar("Error Signing in",e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try{
      await googleSignIn.signOut();
      await _auth.signOut();
    }catch(e){
      Get.snackbar("Error Signing Out",e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

}