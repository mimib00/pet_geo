import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Logout extends StatelessWidget {
  Logout({Key? key}) : super(key: key);

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: MyText(
                    text: 'Отмена',
                    size: 14,
                    weight: FontWeight.w700,
                    color: kInputBorderColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  authController.logout();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: MyText(
                    text: 'Выйти',
                    size: 14,
                    weight: FontWeight.w700,
                    color: kDarkGreyColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
