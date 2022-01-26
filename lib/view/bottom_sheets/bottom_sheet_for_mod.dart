import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class BottomSheetForMod extends StatelessWidget {
  List options = [
    'Удалить',
    'Редактировать',
  ];

  BottomSheetForMod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        itemBuilder: (context, index) => ListTile(
          onTap: () => Get.back(),
          title: Center(
            child: MyText(
              size: 15,
              color: kDarkGreyColor,
              text: options[index],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: kLightGreyColor,
        ),
        itemCount: options.length,
      ),
    );
  }
}
