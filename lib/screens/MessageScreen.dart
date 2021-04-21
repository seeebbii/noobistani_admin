import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/PageChangeController.dart';
import 'package:noobistani_admin/controllers/userController.dart';

class MessageScreen extends StatelessWidget {
  final userController = Get.find<UserController>();
  final pageController = Get.find<PageChangeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("${userController.currentUser.value.name}")),
        leading: IconButton(
          onPressed: (){
            pageController.pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Text("DIRECT MESSAGES"),
      ),
    );
  }
}
