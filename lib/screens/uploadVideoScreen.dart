import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/services/Database.dart';

class UploadVideo extends StatefulWidget {
  File file;

  UploadVideo(this.file);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New post"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: TextButton(
                onPressed: () {
                  Database().uploadVideo(userController.currentUser.value, widget.file);
                },
                child: Text("Upload"),
                autofocus: false,
              )),
        ],
      ),
      body: Column(
        children: [
          // Obx(() {
          //   return userController.isLoading == true ? LinearProgressIndicator(value: userController.uploadedBytes.value.toDouble() ) :  Container();
          // })
        ],
      )
    );
  }
}
