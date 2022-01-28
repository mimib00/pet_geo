import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/user/user.dart';

class Root extends GetWidget<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var user = Get.find<AuthController>().currentUser;
      if (user != null) {
        Get.back();
        controller.getUserData(user.uid);
        return BottomNavBar(currentIndex: 3);
      } else {
        return const Authentication();
      }
    });
  }
}
