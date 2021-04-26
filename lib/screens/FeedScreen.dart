import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/screens/uploadVideoScreen.dart';
import 'package:noobistani_admin/utilities/MyBehavior.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin<FeedScreen> {
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

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date); // Doesn't get called when it should be
    } else {
      time = diff.inDays.toString() + 'DAYS AGO'; // Gets call and it's wrong date
    }

    return time;
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
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              cacheExtent: 500,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text(
                                "${DateTime.fromMicrosecondsSinceEpoch(controller.listOfVideos[index].timestamp!.microsecondsSinceEpoch)}"),
                          )
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
                          : GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: AspectRatio(
                                aspectRatio: 9/16,
                                child: VideoPlayer(
                                    controller.listOfControllers[index]),
                              ),
                            )
                    ],
                  ),
                );
              },
              itemCount: controller.listOfVideos.length,
            ),
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
