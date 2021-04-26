import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/model/videoModel.dart';
import 'package:video_player/video_player.dart';

class MyPostsListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final VideoModel videoModel;

  MyPostsListItem(this.videoPlayerController, this.videoModel);

  @override
  _MyPostsListItemState createState() => _MyPostsListItemState();
}

class _MyPostsListItemState extends State<MyPostsListItem> {
  final userController = Get.find<UserController>();
  @override
  void initState() {
    print(widget.videoModel.name);
    widget.videoPlayerController
      ..initialize()
      ..setLooping(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: SingleChildScrollView(
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
                    Obx(() => CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${userController.currentUser.value.imageUrl}"),
                    )),
                    Obx(() => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("${userController.currentUser.value.name}")
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                          "${DateTime.fromMicrosecondsSinceEpoch(
                              widget.videoModel.timestamp!
                                  .microsecondsSinceEpoch)}"),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                widget.videoPlayerController.value.isInitialized
                    ? GestureDetector(
                    onTap: () {
                      if (widget.videoPlayerController.value.isPlaying) {
                        widget.videoPlayerController.pause();
                      } else {
                        widget.videoPlayerController.play();
                      }
                    },
                    child: AspectRatio(
                      aspectRatio: widget.videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(
                          widget.videoPlayerController),
                    ))
                    : GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: AspectRatio(
                    aspectRatio: 9/16,
                    child: VideoPlayer(
                        widget.videoPlayerController),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}
