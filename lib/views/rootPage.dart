import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/PageChangeController.dart';
import 'package:noobistani_admin/controllers/authController.dart';
import 'package:noobistani_admin/controllers/userController.dart';
import 'package:noobistani_admin/drawer/DrawerItems.dart';
import 'package:noobistani_admin/screens/FeedScreen.dart';
import 'package:noobistani_admin/screens/MessageScreen.dart';
import 'package:noobistani_admin/screens/NewsScreen.dart';
import 'package:noobistani_admin/screens/ProfileScreen.dart';
import 'package:noobistani_admin/services/Database.dart';
import 'package:noobistani_admin/utilities/MyBehavior.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final authController = Get.put(AuthController());
  final userController = Get.put(UserController());
  final pageController = Get.put(PageChangeController());

  int index = 0;

  void refreshUser() async {
    userController.currentUser.value =
        await Database().getUser(authController.currentUser.value!.uid);
  }

  @override
  void initState() {
    refreshUser();
    super.initState();
  }

  List<Widget> screens = [
    NewsScreen(),
    FeedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: PageView(
        controller: pageController.pageController,
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text("Noobistani"),
              actions: [
                IconButton(
                  onPressed: () {
                    pageController.pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                  },
                  icon: Icon(Icons.messenger_outline_sharp),
                ),
              ],
            ),
            drawer: DrawerItems(
              (ctx, i) {
                setState(() {
                  index = i;
                });
              },
            ),
            body: IndexedStack(
              children: screens,
              index: index,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.announcement,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.announcement,
                    color: Colors.purpleAccent.shade100,
                  ),
                  title: Text(
                    "News",
                    style: TextStyle(
                        color: index == 0
                            ? Colors.purpleAccent.shade100
                            : Colors.grey),
                  ),
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.dashboard,
                      color: Colors.purpleAccent.shade100,
                    ),
                    title: Text(
                      "Feed",
                      style: TextStyle(
                          color: index == 1
                              ? Colors.purpleAccent.shade100
                              : Colors.grey),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.person,
                      color: Colors.purpleAccent.shade100,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                          color: index == 2
                              ? Colors.purpleAccent.shade100
                              : Colors.grey),
                    )),
              ],
              onTap: (i) {
                setState(() {
                  index = i;
                });
              },
            ),
          ),
          MessageScreen()
        ],
      ),
    );
  }
}
