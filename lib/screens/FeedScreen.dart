import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/screens/uploadVideoScreen.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with AutomaticKeepAliveClientMixin<FeedScreen> {
  final userController = Get.find<UserController>();
  late VideoPlayerController _controller;
  late File _video;

  final picker = ImagePicker();

  void pickVideo() async {
    // if (_controller.value.isPlaying) _controller.pause();
    final pickedFile = await picker.getVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(seconds: 60),
    );
    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
        print(_video.path);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return UploadVideo(_video);
        }));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<UserController>(builder: (controller) {
        if (controller.listOfVideos.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (_, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    Divider(
                      height: 5,
                      thickness: 0.5,
                      color: Colors.grey.shade800,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${controller.listOfVideos[index].imageUrl}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text("${controller.listOfVideos[index].name}"),
                        ),
                        Text(
                            "${controller.listOfVideos[index].timestamp!.toDate()}")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    controller.listOfControllers[index].value.isInitialized
                        ? GestureDetector(
                            onTap: () {
                              if (controller
                                  .listOfControllers[index].value.isPlaying) {
                                controller.listOfControllers[index].pause();
                              } else {
                                controller.listOfControllers[index].play();
                              }
                            },
                            child: AspectRatio(
                              aspectRatio: controller
                                  .listOfControllers[index].value.aspectRatio,
                              child: VideoPlayer(
                                  controller.listOfControllers[index]),
                            ))
                        : AspectRatio(
                            aspectRatio: controller
                                .listOfControllers[index].value.aspectRatio,
                            child: VideoPlayer(
                                controller.listOfControllers[index]),
                          )
                  ],
                ),
              );
            },
            itemCount: controller.listOfVideos.length,
          );
        } else {
          return Center(
            child: Text("No data"),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent.shade100,
        onPressed: pickVideo,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
