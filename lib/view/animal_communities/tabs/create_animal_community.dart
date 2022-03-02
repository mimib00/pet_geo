import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/community_controller/community_contoller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/pet_geo_executive_profile/pet_geo_executive_profile.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class CreateAnimalCommunity extends StatelessWidget {
  CreateAnimalCommunity({Key? key}) : super(key: key);

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: Get.height * .71,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        hintText: '',
                        label: "название",
                        controller: name,
                        validate: (txt) {
                          if (txt == null || txt.isEmpty) {
                            return "You must enter a name to the comunnity";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        hintText: '',
                        label: "Описание",
                        controller: description,
                        validate: (txt) {
                          if (txt == null || txt.isEmpty) {
                            return "You must enter a name to the comunnity";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: "Logo",
                                size: 12,
                                weight: FontWeight.w700,
                                color: kDarkGreyColor,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: GetBuilder<CommunityController>(
                                    init: CommunityController(),
                                    builder: (controller) {
                                      if (controller.logo == null) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () => Get.bottomSheet(
                                            CameraOption(isLogo: true),
                                            backgroundColor: kPrimaryColor,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                            enableDrag: true,
                                          ),
                                          child: Image.asset(
                                            'assets/images/Icon photo.png',
                                            height: 77,
                                          ),
                                        );
                                      } else {
                                        return Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.file(
                                                File(controller.logo!.path),
                                                height: 77,
                                                width: 77,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () => controller.restImage(true),
                                              child: Container(
                                                width: 77,
                                                height: 77,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: kInputBorderColor),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.restart_alt_rounded,
                                                    color: kInputBorderColor,
                                                    size: 35,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: "Profile Cover",
                                size: 12,
                                weight: FontWeight.w700,
                                color: kDarkGreyColor,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: GetBuilder<CommunityController>(
                                    init: CommunityController(),
                                    builder: (controller) {
                                      if (controller.image == null) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () => Get.bottomSheet(
                                            CameraOption(
                                              isLogo: false,
                                            ),
                                            backgroundColor: kPrimaryColor,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                            enableDrag: true,
                                          ),
                                          child: Image.asset(
                                            'assets/images/Icon photo.png',
                                            height: 77,
                                          ),
                                        );
                                      } else {
                                        return Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.file(
                                                File(controller.image!.path),
                                                height: 77,
                                                width: 77,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () => controller.restImage(false),
                                              child: Container(
                                                width: 77,
                                                height: 77,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: kInputBorderColor),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.restart_alt_rounded,
                                                    color: kInputBorderColor,
                                                    size: 35,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: SizedBox(
                    width: Get.width * 0.78,
                    child: MyButton(
                      text: 'Создать сообщество',
                      textSize: 16,
                      weight: FontWeight.w700,
                      btnBgColor: kSecondaryColor,
                      height: 47,
                      radius: 12.0,
                      onPressed: () {
                        final CommunityController controller = Get.find<CommunityController>();
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            "name": name.text.trim(),
                            "description": description.text.trim(),
                          };

                          Get.defaultDialog(
                            title: "",
                            content: Obx(() => Text(controller.status.value)),
                          );

                          controller.createComunity(data);
                        }
                      },
                      // onPressed: () => Get.to(() => const PetGeoExecutiveProfile()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraOption extends StatelessWidget {
  final bool isLogo;
  CameraOption({Key? key, required this.isLogo}) : super(key: key);

  final List options = [
    'camera_title'.tr,
    'gallery_title'.tr,
  ];
  final CommunityController controller = Get.put<CommunityController>(CommunityController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            controller.getImage(options[index] == "camera_title".tr, isLogo);
            Get.back();
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
