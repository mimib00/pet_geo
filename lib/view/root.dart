import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/auth_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/user/user.dart';

class Root extends GetWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<AuthController>().currentUser != null ? BottomNavBar() : const Authentication();
    });
  }
}
