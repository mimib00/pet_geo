import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/offer_help/congrats.dart';

import '../charity_enter_amount_box.dart';
import '../custom_app_bar_1.dart';
import '../my_text.dart';

class ByBonuses extends StatelessWidget {
  const ByBonuses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar1(
        haveTitle: true,
        title: 'Помощь',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MyText(
                        text: 'На вашем счету',
                        size: 16,
                        color: kDarkGreyColor,
                        fontFamily: 'Roboto',
                      ),
                      MyText(
                        text: '850',
                        size: 18,
                        paddingLeft: 10.0,
                        paddingRight: 15.0,
                        color: kDarkGreyColor,
                        weight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                      Image.asset(
                        'assets/images/Charity.png',
                        height: 22,
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        MyText(
                          text: 'Перевести',
                          size: 18,
                          paddingBottom: 10.0,
                          color: kDarkGreyColor,
                          fontFamily: 'Roboto',
                        ),
                        const CharityEnterAmountBox(),
                      ],
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.7,
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    height: 47,
                    color: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () => Get.to(() => const Congrats()),
                    child: MyText(
                      text: 'Помочь',
                      size: 16,
                      weight: FontWeight.w700,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
