// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Login extends GetWidget<AuthController> {
  Login({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          physics: const BouncingScrollPhysics(),
          children: [
            CustomTextField(
              controller: email,
              hintText: 'IvanovIvan@pochta.ru',
              label: 'email_title'.tr,
              validate: (txt) {
                var emailValid = EmailValidator(errorText: 'Unvalid email address format').call(txt);
                var isEmpty = RequiredValidator(errorText: 'Email is required').call(txt);
                if (isEmpty == null) {
                  if (emailValid != null) {
                    return emailValid;
                  }
                } else {
                  return isEmpty;
                }
              },
            ),
            CustomTextField(
              controller: password,
              hintText: '********',
              label: 'password_title'.tr,
              obscureText: true,
              validate: MultiValidator([
                RequiredValidator(errorText: 'Password is required'),
                MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              btnBgColor: kLightOrangeColor,
              text: 'login'.toUpperCase().tr,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.defaultDialog(
                    title: "",
                    titlePadding: EdgeInsets.zero,
                    content: const Text(
                      "Loading...",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
                  controller.login(email.text.trim(), password.text.trim());
                }
              },
            ),
            MyText(
              paddingTop: 25.0,
              text: 'password_rest'.tr,
              weight: FontWeight.w600,
              color: kSecondaryColor,
              align: TextAlign.end,
            ),
            // GetBuilder<LoginController>(
            //     init: LoginController(),
            //     builder: (logic) {
            //       return GestureDetector(
            //         onTap: () {
            //           logic.guestUser();
            //           Get.off(
            //             () => FoundAPet(
            //               guestUser: logic.isGuest,
            //             ),
            //           );
            //         },
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: Get.height * 0.05,
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 MyText(
            //                   text: 'Войти как',
            //                   weight: FontWeight.w600,
            //                   color: kInputBorderColor,
            //                   align: TextAlign.end,
            //                 ),
            //                 MyText(
            //                   text: ' Гость',
            //                   weight: FontWeight.w600,
            //                   color: kSecondaryColor,
            //                   align: TextAlign.end,
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}
