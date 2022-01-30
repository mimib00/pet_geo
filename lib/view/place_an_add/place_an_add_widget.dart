import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
  TextEditingController? petBreed = TextEditingController();
  TextEditingController? petNickName = TextEditingController();
  TextEditingController? petColor = TextEditingController();
  TextEditingController? petAge = TextEditingController();
  TextEditingController? comment = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var categoryName, categoryColor;
  bool? payment;
  VoidCallback? onTap;

  PlaceAnAddWidget({
    Key? key,
    this.categoryName,
    this.categoryColor = kGreenColor,
    this.petBreed,
    this.petNickName,
    this.petColor,
    this.petAge,
    this.comment,
    this.payment = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar1(),
      body: ListView(
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
          const SizedBox(
            height: 30,
          ),
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
                        MyText(
                          text: 'Тип животного'.toUpperCase(),
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
                ),
              ),
              const SizedBox(
                width: 30,
              ),
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
                        MyText(
                          text: 'Пол'.toUpperCase(),
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
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: PlaceAnAddTextFields(
                  textEditingController: petBreed,
                  hintText: 'Порода',
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: PlaceAnAddTextFields(
                  textEditingController: petNickName,
                  hintText: 'Кличка',
                ),
              ),
            ],
          ),
          payment == true
              ? const SizedBox(
                  height: 22,
                )
              : const SizedBox(),
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
                        textEditingController: petColor,
                        hintText: 'Окрас',
                      ),
              ),
              const SizedBox(
                width: 30,
              ),
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
                        MyText(
                          text: 'Возраст'.toUpperCase(),
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
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          PlaceAnAddTextFields(
            textEditingController: comment,
            hintText: 'Комментарий',
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    child: Image.asset(
                      'assets/images/Icon photo.png',
                      height: 77,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              'assets/images/IFFfTVE9CMQ 1.png',
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            elevation: 0,
            highlightElevation: 0,
            height: 47,
            color: kSecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              onTap!();
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
    );
  }
}

// ignore: must_be_immutable
class PlaceAnAddTextFields extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var hintText;
  TextEditingController? textEditingController;

  PlaceAnAddTextFields({
    Key? key,
    this.hintText,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextField(
        controller: textEditingController,
        cursorColor: kDarkGreyColor,
        style: const TextStyle(
          fontSize: 12,
          color: kDarkGreyColor,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: '$hintText'.toUpperCase(),
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
