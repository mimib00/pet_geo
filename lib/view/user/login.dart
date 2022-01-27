import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/login_controller/login_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/place_an_add/found_a_pet.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/my_text_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var value = false;
  Color buttonColor = kLightOrangeColor;

  TextEditingController email = TextEditingController();
  // late TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        physics: const BouncingScrollPhysics(),
        children: [
          // MyTextField(
          //   onChanged: (value) {
          //     setState(() {
          //       value.length > 1
          //           ? buttonColor = kSecondaryColor
          //           : buttonColor = kLightOrangeColor;
          //     });
          //   },
          //   lableText: 'Имя пользователя или e-mail',
          //   hintText: 'IvanovIvan@pochta.ru',
          // ),
          CustomTextField(
            controller: email,
            hintText: 'IvanovIvan@pochta.ru',
            label: 'Имя пользователя или e-mail',
          ),
          MyTextField(
            onChanged: (value) {
              setState(() {
                value.length > 1 ? buttonColor = kSecondaryColor : buttonColor = kLightOrangeColor;
                if (kDebugMode) {
                  print(value);
                }
              });
            },
            staricIcon: true,
            obsecure: true,
            lableText: 'Пароль',
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
            onPressed: () => Get.to(
              () => BottomNavBar(
                currentIndex: 3,
              ),
            ),
          ),
          MyText(
            paddingTop: 25.0,
            text: 'Забыли пароль?',
            weight: FontWeight.w600,
            color: kSecondaryColor,
            align: TextAlign.end,
          ),
          GetBuilder<LoginController>(
              init: LoginController(),
              builder: (logic) {
                return GestureDetector(
                  onTap: () {
                    logic.guestUser();
                    Get.off(
                      () => FoundAPet(
                        guestUser: logic.isGuest,
                      ),
                    );
                  },
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
                );
              }),
        ],
      ),
    );
  }
}
