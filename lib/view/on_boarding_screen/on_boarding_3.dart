import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          'assets/images/on3.png',
          height: Get.height * 0.82,
        ),
      ),
    );
  }
}
