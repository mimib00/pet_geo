import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:pet_geo/view/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Connectivity().checkConnectivity().then((connectivityResult) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        var firstTime = prefs.getBool("first_time");
        if (firstTime == null || firstTime == true) {
          Get.offAll(() => OnBoardingScreen());
        } else {
          if (FirebaseAuth.instance.currentUser == null) {
            Get.offAll(() => const Authentication());
          } else {
            Get.offAll(() => BottomNavBar());
          }
        }
      } else {
        Get.defaultDialog(
          title: "No Internet connection",
          content: SizedBox(
            height: Get.height * .1,
            child: const Center(child: Text("Please connect then retry again")),
          ),
          barrierDismissible: false,
        );
      }
    });
  }
}
