import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/settings/settings.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Onboarding5 extends StatelessWidget {
  const Onboarding5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kSecondaryColor,
        image: DecorationImage(
          image: AssetImage('assets/images/Component 124.png'),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Vector Smart Object 1.png',
            height: 76,
          ),
          GestureDetector(
            onTap: () => Get.to(() => Settings()),
            child: MyText(
              text: 'Начать',
              size: 48,
              weight: FontWeight.w700,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
