import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_1.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_2.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_3.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_4.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_5.dart';
import 'package:pet_geo/view/settings/settings.dart';
import 'package:pet_geo/view/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreenController extends GetxController {
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;
  final RxList pages = [
    const Onboarding1(),
    const Onboarding2(),
    const Onboarding3(),
    const Onboarding4(),
    const Onboarding5(),
  ].obs;

  void lastPage(bool? onBoardingStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (currentIndex.value == 4 && onBoardingStatus == true) {
      Get.offAll(() => const Authentication());
      prefs.setBool("first_time", false);
    }
    update();
  }
}
