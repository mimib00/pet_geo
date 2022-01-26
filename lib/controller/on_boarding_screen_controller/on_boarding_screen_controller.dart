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

class OnBoardingScreenController extends GetxController {
  var pageController = PageController();
  RxInt currentIndex = 0.obs;
  final RxList pages = [
    const Onboarding1(),
    const Onboarding2(),
    const Onboarding3(),
    const Onboarding4(),
    const Onboarding5(),
  ].obs;

  void lastPage(bool? onBoardingStatus) {
    if (currentIndex.value == 4 && onBoardingStatus == true) {
      Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () => Get.offAll(() => const User()),
      );
      if (kDebugMode) {
        print(onBoardingStatus.toString());
      }
    } else {
      currentIndex.value == 4
          ? Future.delayed(
              const Duration(
                seconds: 2,
              ),
              () => Get.off(() => Settings()),
            )
          // ignore: avoid_print
          : print('index is not last');
    }
    update();
  }
}
