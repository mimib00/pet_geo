import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/custom_app_bar_1.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Congrats extends StatelessWidget {
  const Congrats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Events Logo.png',
                    height: 80,
                  ),
                  MyText(
                    paddingTop: 40.0,
                    size: 24,
                    align: TextAlign.center,
                    color: kDarkGreyColor,
                    weight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    text: 'Спасибо за  Вашу помощь!',
                  ),
                  MyText(
                    paddingTop: 10.0,
                    size: 18,
                    align: TextAlign.center,
                    color: kDarkGreyColor,
                    fontFamily: 'Roboto',
                    text: 'Перевод совершен',
                  ),
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
                    onPressed: () {},
                    child: MyText(
                      text: 'Вернуться на страницу',
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
