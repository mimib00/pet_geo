import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:pet_geo/view/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  final AuthController controller = Get.find<AuthController>();
  @override
  void onInit() {
    super.onInit();
  }
}
