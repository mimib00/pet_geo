import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/place_an_add_controller/place_an_add_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import '../../controller/pet_controller.dart';

// ignore: must_be_immutable
class Gender extends StatelessWidget {
  Gender({Key? key}) : super(key: key);
  PlaceAnAdController controller = Get.find<PlaceAnAdController>();
  PetController petController = Get.put<PetController>(PetController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        itemBuilder: (context, index) => ListTile(
          onTap: () => {
            controller.selectGender(index),
            petController.selectGender(index),
            Get.back()
          },
          title: Center(
            child: MyText(
              size: 15,
              color: kDarkGreyColor,
              text: controller.gender[index].tr,
            ),
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: kLightGreyColor,
        ),
        itemCount: controller.gender.length,
      ),
    );
  }
}
