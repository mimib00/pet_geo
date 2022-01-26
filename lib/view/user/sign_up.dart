import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/my_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var value = false;
  var buttonColor = kLightOrangeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        physics: const BouncingScrollPhysics(),
        children: [
          MyTextField(
            onChanged: (value) {
              setState(() {
                value.length > 1
                    ? buttonColor = kSecondaryColor
                    : buttonColor = kLightOrangeColor;
                if (kDebugMode) {
                  print(value);
                }
              });
            },
            lableText: 'Напишите e-mail',
            hintText: 'IvanovIvan@pochta.ru',
          ),
          MyTextField(
            obsecure: true,
            lableText: 'Придумайте пароль',
            hintText: '********',
          ),
          MyTextField(
            obsecure: true,
            lableText: 'Повторите пароль',
            hintText: '********',
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    value = !value;
                  });
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kLightGreyColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: value == true
                        ? Image.asset(
                            'assets/images/check.png',
                            height: 16.5,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              Expanded(
                child: MyText(
                  paddingLeft: 15.0,
                  text: 'Запомнить меня',
                  size: 12,
                  weight: FontWeight.w600,
                  color: kDarkGreyColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
            btnBgColor: buttonColor,
            text: 'Войти'.toUpperCase(),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: 'Войти как',
                      weight: FontWeight.w600,
                      color: kInputBorderColor,
                      align: TextAlign.end,
                    ),
                    MyText(
                      text: ' Гость',
                      weight: FontWeight.w600,
                      color: kSecondaryColor,
                      align: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
