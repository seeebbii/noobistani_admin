import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noobistani_admin/views/LoginScreen.dart';
import 'package:noobistani_admin/views/rootPage.dart';

import 'controllers/authController.dart';
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Get.put(AuthController()).currentUser.value?.uid != null ? RootPage() : LoginScreen() );
  }
}
