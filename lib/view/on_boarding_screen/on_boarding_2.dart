import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      // padding: const EdgeInsets.only(top: 40),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          'assets/images/on2.png',
          height: Get.height * 0.72,
        ),
      ),
    );
  }
}
