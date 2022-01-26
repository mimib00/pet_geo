import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                onTap: () {},
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
