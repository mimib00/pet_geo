import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class OptionsForUserProfile extends StatelessWidget {
  List options = [
    'Заблокировать',
    'Убрать из друзей',
  ];

  OptionsForUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 20, top: 20),
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
    );
  }
}
