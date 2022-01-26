import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/on_boarding_screen_controller/on_boarding_screen_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            children: [
              Image.asset(
                'assets/images/Vector Smart Object 1.png',
                color: kPrimaryColor,
                height: 172,
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/PetGeo (3).png',
                color: kPrimaryColor,
                height: 200,
              ),
            ],
          ),
          GetBuilder<OnBoardingScreenController>(
              init: OnBoardingScreenController(),
              builder: (logic) {
                return GestureDetector(
                  onTap: () => logic.pageController.nextPage(
                    duration: const Duration(microseconds: 1),
                    curve: Curves.easeIn,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: 'Узнать о приложении',
                        size: 15,
                        weight: FontWeight.w600,
                        color: kPrimaryColor,
                        paddingRight: 7.0,
                        paddingBottom: 4.0,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: kPrimaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
