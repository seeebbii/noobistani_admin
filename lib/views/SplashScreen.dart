import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/authController.dart';
import 'package:noobistani_admin/views/LoginScreen.dart';
import 'package:noobistani_admin/views/rootPage.dart';

import '../root.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLoggedInUser() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedInUser().then((status) {
      if (status) {
        navigateToRoot();
      }
    });
  }
  void navigateToRoot() {
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) {
      return Root();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade900.withOpacity(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/nbLogo.png',
              height: 400,
              width: 1000,
              fit: BoxFit.cover,
            ),
            Container(
              child: Text(
                'NOOBISTANI',
                style: TextStyle(
                  fontFamily: 'Chilanka',
                  fontSize: 20,
                  letterSpacing: 2.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
