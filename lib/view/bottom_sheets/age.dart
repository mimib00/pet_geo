import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class Age extends StatelessWidget {
  List ages = [
    'Взрослый',
    'Маленький',
  ];

  Age({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        itemBuilder: (context, index) => ListTile(
          onTap: () => Get.back(),
          title: Center(
            child: MyText(
              size: 15,
              color: kDarkGreyColor,
              text: ages[index],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: kLightGreyColor,
        ),
        itemCount: ages.length,
      ),
    );
  }
}
