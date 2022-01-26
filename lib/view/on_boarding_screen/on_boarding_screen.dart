import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/on_boarding_screen_controller/on_boarding_screen_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  bool? status;

  OnBoardingScreen({
    Key? key,
    this.status = false,
  }) : super(key: key);

  OnBoardingScreenController controller = Get.put(OnBoardingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Obx(
        () {
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: PageView.builder(
                  onPageChanged: (index) {
                    controller.currentIndex.value = index;
                    controller.lastPage(status);
                  },
                  controller: controller.pageController,
                  itemCount: controller.pages.length,
                  itemBuilder: (context, index) => controller.pages[index],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: kSecondaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentIndex.value == index ? kPrimaryColor : kPrimaryColor.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
