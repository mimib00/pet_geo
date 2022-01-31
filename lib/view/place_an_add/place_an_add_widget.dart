import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/controller/place_an_add_controller/place_an_add_controller.dart';
import 'package:pet_geo/view/bottom_sheets/age.dart';
import 'package:pet_geo/view/bottom_sheets/camera_options.dart';
import 'package:pet_geo/view/bottom_sheets/gender.dart';
import 'package:pet_geo/view/bottom_sheets/payment_method.dart';
import 'package:pet_geo/view/bottom_sheets/pet_type.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/custom_app_bar_1.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class PlaceAnAddWidget extends StatelessWidget {
  TextEditingController petBreed = TextEditingController();
  TextEditingController petNickName = TextEditingController();
  TextEditingController petColor = TextEditingController();
  TextEditingController petAge = TextEditingController();
  TextEditingController comment = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var categoryName, categoryColor;
  bool? payment;
  VoidCallback? onTap;

  PlaceAnAddWidget({
    Key? key,
    this.categoryName,
    this.categoryColor = kGreenColor,
    this.payment = false,
    this.onTap,
  }) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (mapController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar1(),
          body: Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              children: [
                MaterialButton(
                  elevation: 0,
                  highlightElevation: 0,
                  height: 34,
                  color: categoryColor,
                  shape: const StadiumBorder(),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: MyText(
                          text: '$categoryName',
                          size: 15,
                          align: TextAlign.left,
                          weight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: kInputBorderColor,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.bottomSheet(
                            PetType(),
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            enableDrag: true,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () {
                                  PlaceAnAdController controller = Get.find<PlaceAnAdController>();
                                  return MyText(
                                    text: controller.selectedAnimal.value.tr.toUpperCase(),
                                    size: 12,
                                    weight: FontWeight.w600,
                                    color: kDarkGreyColor,
                                  );
                                },
                              ),
                              Image.asset(
                                'assets/images/Polygon 2.png',
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: kInputBorderColor,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.bottomSheet(
                            Gender(),
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            enableDrag: true,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () {
                                  PlaceAnAdController controller = Get.find<PlaceAnAdController>();
                                  return MyText(
                                    text: controller.selectedGender.value.tr.toUpperCase(),
                                    size: 12,
                                    weight: FontWeight.w600,
                                    color: kDarkGreyColor,
                                  );
                                },
                              ),
                              Image.asset(
                                'assets/images/Polygon 2.png',
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: PlaceAnAddTextFields(
                        controller: petBreed,
                        hintText: 'breed_title'.tr,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: PlaceAnAddTextFields(
                        controller: petNickName,
                        hintText: 'nickname_title'.tr,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: payment == true
                          ? Container(
                              padding: const EdgeInsets.only(
                                bottom: 7,
                                left: 20,
                                right: 5,
                              ),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: kInputBorderColor,
                                  ),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () => Get.bottomSheet(
                                  PaymentMethod(),
                                  backgroundColor: kPrimaryColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  enableDrag: true,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: 'Способ'.toUpperCase(),
                                      size: 12,
                                      weight: FontWeight.w600,
                                      color: kDarkGreyColor,
                                    ),
                                    Image.asset(
                                      'assets/images/Polygon 2.png',
                                      height: 6,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : PlaceAnAddTextFields(
                              controller: petColor,
                              hintText: 'Окрас',
                            ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 7, left: 20, right: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: kInputBorderColor,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.bottomSheet(
                            Age(),
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            enableDrag: true,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                PlaceAnAdController controller = Get.find<PlaceAnAdController>();
                                return MyText(
                                  text: controller.age.value.tr.toUpperCase(),
                                  size: 12,
                                  weight: FontWeight.w600,
                                  color: kDarkGreyColor,
                                );
                              }),
                              Image.asset(
                                'assets/images/Polygon 2.png',
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                PlaceAnAddTextFields(
                  controller: comment,
                  hintText: 'Комментарий',
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: GetBuilder<PlaceAnAdController>(
                          builder: (controller) {
                            if (controller.image == null) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => Get.bottomSheet(
                                  CameraOptions(),
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
                                    onTap: () => controller.restImage(),
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
                        // child: Image.asset(
                        //   'assets/images/Icon photo.png',
                        //   height: 77,
                        // ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .2,
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: GoogleMap(
                      initialCameraPosition: mapController.initialPosition,
                      zoomControlsEnabled: false,
                      onMapCreated: (controller) {
                        if (!mapController.ctrl.isCompleted) {
                          mapController.ctrl.complete(controller);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  highlightElevation: 0,
                  height: 47,
                  color: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    PlaceAnAdController controller = Get.find<PlaceAnAdController>();
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "nickname": petNickName.text.trim(),
                        "breed": petBreed.text.trim(),
                        "comment": comment.text.trim(),
                        "color": petColor.text.trim(),
                      };

                      Get.defaultDialog(
                        title: "",
                        content: Obx(() => Text(controller.status.value)),
                      );

                      controller.placeAd(data);
                    }
                  },
                  child: MyText(
                    text: 'Разместить объявление',
                    size: 16,
                    weight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class PlaceAnAddTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validate;
  final TextInputType keyboardType;

  const PlaceAnAddTextFields({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        controller: controller,
        cursorColor: kDarkGreyColor,
        style: const TextStyle(
          fontSize: 12,
          color: kDarkGreyColor,
          fontWeight: FontWeight.w600,
        ),
        validator: validate,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: hintText.toUpperCase(),
          hintStyle: const TextStyle(
            fontSize: 12,
            color: kDarkGreyColor,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kInputBorderColor,
              width: 1.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kInputBorderColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
