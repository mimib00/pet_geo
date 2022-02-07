// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class SignUp extends GetWidget<AuthController> {
  SignUp({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

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
                  if (emailValid == null) {
                    // check if user exists.
                    controller.userExist(email.text);
                  } else {
                    return emailValid;
                  }
                } else {
                  return isEmpty;
                }
                return null;
              },
            ),
            CustomTextField(
              controller: password,
              obscureText: true,
              hintText: '********',
              label: 'password_title'.tr,
              validate: MultiValidator([
                RequiredValidator(errorText: 'Password is required'),
                MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
              ]),
            ),
            CustomTextField(
              controller: confirm,
              obscureText: true,
              hintText: '********',
              label: 'confirm_password_title'.tr,
              validate: (txt) => MatchValidator(errorText: 'passwords do not match').validateMatch(confirm.text.trim(), password.text),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              btnBgColor: kLightOrangeColor,
              text: 'register'.toUpperCase().tr,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.defaultDialog(content: const Text("Loading..."));
                  controller.createUser(email.text.trim(), password.text.trim());
                }
              },
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
                        text: 'login_as'.tr,
                        weight: FontWeight.w600,
                        color: kInputBorderColor,
                        align: TextAlign.end,
                      ),
                      MyText(
                        text: ' guest'.tr,
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
      ),
    );
  }
}
