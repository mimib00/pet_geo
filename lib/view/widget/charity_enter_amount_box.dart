import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

class CharityEnterAmountBox extends StatelessWidget {
  const CharityEnterAmountBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: Get.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: kSecondaryColor,
          width: 2.0,
        ),
      ),
      child: TextField(
        enabled: false,
        cursorColor: kDarkGreyColor,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
        decoration: InputDecoration(
          prefixIcon: Column(),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Charity.png',
                height: 24,
              ),
            ],
          ),
          hintText: '0',
          hintStyle: const TextStyle(
            fontSize: 24,
            color: kDarkGreyColor,
            fontFamily: 'Roboto',
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
