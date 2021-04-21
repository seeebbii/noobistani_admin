import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/controllers/authController.dart';
import 'package:noobistani_admin/controllers/userController.dart';

class DrawerItems extends StatelessWidget {

  late Function onTap;


  DrawerItems(this.onTap);

  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade900,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            GetX<UserController>(
              builder: (controller) {
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey.shade900),
                  accountName: Text(
                    controller.currentUser.value.name ?? "",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    controller.currentUser.value.email ?? "",
                    style: TextStyle(fontSize: 12),
                  ),
                  currentAccountPicture: controller.currentUser.value.imageUrl == ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.network(
                            'https://pbs.twimg.com/profile_images/1275457579078922240/BcW-3ekn.jpg',
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(controller.currentUser.value.imageUrl ?? "")),
                );
              }
            ),
            Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              title: Text(
                'News',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.personal_video,
                color: Colors.white,
              ),
              title: Text(
                'Tournaments',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people_outline,
                color: Colors.white,
              ),
              title: Text(
                'Rosters',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Image.asset('assets/logo/tshirt.png', height: 25, color: Colors.white,),
              title: Text(
                'Merchandise',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 3);
                Navigator.of(context).pop();
              },
            ),
            Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
              color: Colors.grey,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: (){
                authController.signOut();
                },
            ),
          ],
        ),
      ),
    );
  }
}
