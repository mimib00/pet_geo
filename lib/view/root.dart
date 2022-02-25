import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/user/user.dart';

class Root extends GetWidget<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // // return GetBuilder<AuthController>(
    // //   builder: (controller) {
    // //     var user = controller.currentUser;

    // //     if (user.value != null) {
    // //       controller.getUserData(user.value!.uid);
    // //       return BottomNavBar(currentIndex: 3);
    // //     } else {
    // //       return const Authentication();
    // //     }
    // //   },
    // // );
    // return Obx(() {
    //   FirebaseAuth.instance.authStateChanges().listen((user) {
    //     if (user.value != null) {
    //       controller.getUserData(user.value!.uid);
    //       return BottomNavBar(currentIndex: 3);
    //     } else {
    //       return const Authentication();
    //     }
    //   });
    //   // var user = Get.find<AuthController>().currentUser;

    // });
  }
}
