import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/model/videoModel.dart';
import 'package:noobistani_admin/screens/ChewieListItem.dart';
import 'package:noobistani_admin/services/Database.dart';
import 'package:noobistani_admin/utilities/MyBehavior.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
  }

  Future<Uint8List> _getImage(videoPathUrl) async {
    Uint8List? thumb = await VideoThumbnail.thumbnailData(
        video: videoPathUrl,
        imageFormat: ImageFormat.PNG,
        //this image will store in created folderpath
        quality: 10);
    return thumb!;
  }

  Uint8List byteList = new Uint8List.fromList([
    137,
    80,
    78,
    71,
    13,
    10,
    26,
    10,
    0,
    0,
    0,
    13,
    73,
    72,
    68,
    82,
    0,
    0,
    0,
    240,
    0,
    0,
    1,
    64,
    8,
    2,
    0,
    0,
    0,
    13,
    138,
    102,
    4,
    0,
    0,
    0,
    3,
    115,
    66,
    73,
    84,
    5,
    6,
    5,
    51,
    11,
    141,
    128,
    0,
    0,
    32,
    0,
    73,
    68,
    65,
    84,
    120,
    156,
    237,
    157,
    207,
    139,
    28,
    71,
    218,
    231,
    191,
    90,
    162,
    225,
    9,
    200,
    130,
    8,
    144,
    32,
    19,
    186,
    65,
    9,
    50,
    76,
    137,
    53,
    184,
    23,
    15,
    140,
    4,
    62,
    184,
    247,
    166,
    197,
    135,
    241,
    123,
    26,
    159,
    223,
    235,
    30,
    6,
    237,
    123,
    88,
    102,
    216,
    195,
    242,
    30,
    95,
    51,
    151,
    189,
    13,
    254,
    19,
    164,
    185,
    189,
    199,
    158,
    131,
    65,
    50,
    216,
    168,
    7,
    6,
    84,
    134,
    17,
    164,
    161,
    5,
    145,
    80,
    13,
    25,
    208,
    5,
    249,
    64,
    231,
    97,
    15,
    81,
    149,
    170,
    86,
    171,
    219,
    174,
    236,
    200,
    234,
    233,
    224,
    249,
    96,
    132,
    104,
    183,
    158,
    172,
    204,
    252,
    102,
    252,
    170,
    170,
    79,
    220,
    121,
    250,
    111,
    79,
    177,
    9,
    68,
    228,
    189,
    39,
    69,
    95,
    255,
    233,
    235,
    254,
    39,
    0,
    152,
    121,
    163,
    58,
    191,
    132,
    63,
    252,
    239,
    63,
    104,
    173,
    219,
    179,
    150,
    23,
    12,
    21,
    167,
    166,
    63,
    241,
    0,
    242,
    60,
    183,
    214,
    50,
    243,
    31,
    255,
    207,
    31,
    227,
    212,
    189,
    156,
    167,
    255,
    246,
    148,
    20,
    11
  ]);

  void showBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: new Wrap(
              children: [
                TextField()
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Obx(
                  () =>
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Stack(children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: CircleAvatar(
                                    maxRadius: 50,
                                    child: Image.network(
                                      '${userController.currentUser.value
                                          .imageUrl ??
                                          "https://pbs.twimg.com/profile_images/1275457579078922240/BcW-3ekn.jpg"}',
                                    ),
                                  )),
                              Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Container(
                                      height: 25,
                                      width: 25,
                                      child: FloatingActionButton(
                                        heroTag: "btn1",
                                        splashColor: Colors.black,
                                        onPressed: () {
                                        },
                                        backgroundColor: Colors.purpleAccent
                                            .shade100,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ))),
                            ]),
                          ),
                          Text(
                            "${userController.currentUser.value.name}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(width: 15,),
                          IconButton(onPressed: (){
                            showBottomSheet(context);
                          }, icon: Icon(Icons.edit))
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: Text("${userController.currentUser.value.bio}"),
                      ),
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        indent: 50,
                        endIndent: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 500,
                        child: StreamBuilder<List<VideoModel>>(
                            stream: Database()
                                .getUserVideos(
                                userController.currentUser.value.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: GridView.builder(
                                      shrinkWrap: false,
                                      itemCount: snapshot.data!.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 1,
                                          mainAxisSpacing: 3,
                                          childAspectRatio: 0.8),
                                      itemBuilder: (_, index) {
                                        return FutureBuilder<Uint8List>(
                                            future: _getImage(
                                                snapshot.data![index].videoUrl),
                                            builder: (context,
                                                AsyncSnapshot<Uint8List> snap) {
                                              if (snap.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasData) {
                                                  return InkWell(
                                                    onTap: (){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                                        return MyPostsListItem(VideoPlayerController.network(snapshot.data![index].videoUrl), snapshot.data![index]);
                                                      }));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.all(3),
                                                      child: Image.memory(
                                                          snap.data ?? byteList),
                                                    ),
                                                  );
                                                } else {
                                                  return Center(
                                                      child: CircularProgressIndicator(color: Colors.purpleAccent.shade100,)
                                                  );
                                                }
                                              } else {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                            }
                                        );
                                      }),
                                );
                              } else {
                                return Center(
                                  child: Text("No Data"),
                                );
                              }
                            }),
                      )
                    ],
                  ),
            )));
  }
}
