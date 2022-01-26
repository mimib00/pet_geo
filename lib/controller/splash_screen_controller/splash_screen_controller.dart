import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        Get.offAll(() => OnBoardingScreen());
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
