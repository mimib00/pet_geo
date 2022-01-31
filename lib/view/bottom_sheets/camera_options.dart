import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_geo/controller/place_an_add_controller/place_an_add_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class CameraOptions extends StatelessWidget {
  List options = [
    'camera_title'.tr,
    'gallery_title'.tr,
  ];

  CameraOptions({Key? key}) : super(key: key);

  PlaceAnAdController controller = Get.find<PlaceAnAdController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        itemBuilder: (context, index) => ListTile(
          onTap: () => {
            controller.getImage(options[index] == "camera_title".tr),
            Get.back()
          },
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
