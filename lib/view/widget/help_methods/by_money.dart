import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/offer_help/congrats.dart';

import '../custom_app_bar_1.dart';
import '../my_text.dart';

class ByMoney extends StatelessWidget {
  const ByMoney({Key? key}) : super(key: key);

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
            flex: 9,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: 'Перевести',
                        size: 18,
                        paddingBottom: 10.0,
                        align: TextAlign.center,
                        color: kDarkGreyColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: kSecondaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
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
                                  'assets/images/₽.png',
                                  height: 22,
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
                      ),
                    ),
                  ],
                ),
                Card(
                  margin: const EdgeInsets.only(top: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 4,
                  child: Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/visa_PNG4 1.png',
                              height: 15,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Image.asset(
                              'assets/images/1200px-Mastercard_2019_logo 1.png',
                              height: 15,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Image.asset(
                              'assets/images/1280px-Maestro_2016 1.png',
                              height: 15,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Image.asset(
                              'assets/images/american-express-6-675747 1.png',
                              height: 40,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Image.asset(
                              'assets/images/mir-logo-h229px 1.png',
                              height: 13,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CardFields(
                          labelText: 'Номер карты',
                          hintText: ' ',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyText(
                          text: 'Дейстувет до',
                          align: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CardFields(
                                      haveLabel: false,
                                      labelText: '',
                                      hintText: 'MM',
                                    ),
                                  ),
                                  MyText(
                                    text: '/',
                                    size: 36,
                                    paddingLeft: 10.0,
                                    paddingRight: 10.0,
                                    weight: FontWeight.w300,
                                  ),
                                  Expanded(
                                    child: CardFields(
                                      haveLabel: false,
                                      labelText: ' ',
                                      hintText: 'ГГ',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 4,
                  child: Container(
                      height: 100,
                    color: kDarkGreyColor.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(
                          text: 'CVV/CVC',
                          color: kDarkGreyColor,
                          size: 14,
                          align: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: kPrimaryColor),
                                    child: CardFields(
                                      haveLabel: false,
                                      labelText: '',
                                      hintText: ' ',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: MyText(
                                  text: 'три цифры\nс обратной стороны карты',
                                  size: 12,
                                  color: kDarkGreyColor,
                                  paddingLeft: 10.0,
                                  weight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ],
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
                      text: 'Отправить',
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

// ignore: must_be_immutable
class CardFields extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var labelText, hintText;
  bool? haveLabel;

  CardFields({Key? key,
    this.labelText,
    this.hintText,
    this.haveLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            haveLabel == true
                ? MyText(
                    paddingBottom: 10.0,
                    text: labelText ?? ' ',
                    size: 14,
                  )
                : const SizedBox(),
          ],
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          cursorColor: kDarkGreyColor,
          style: const TextStyle(
            color: kDarkGreyColor,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            hintText: '$hintText',
            hintStyle: const TextStyle(
              color: kInputBorderColor,
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: kInputBorderColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: kInputBorderColor,
                width: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
