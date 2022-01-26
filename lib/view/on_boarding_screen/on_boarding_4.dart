import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/on4.png',
            height: Get.height * 0.8,
          ),
        ),
      ),
    );
  }
}
