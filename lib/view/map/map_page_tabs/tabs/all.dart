import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/pets_profile/pets_profile.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class All extends StatelessWidget {
  const All({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (logic) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: GestureDetector(
                  onTap: () => logic.hideBluePinPopUp(),
                  child: Image.asset(
                    'assets/images/IFFfTVE9CMQ 1 (1).png',
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: Get.width * 0.160,
                top: Get.height * 0.2,
                child: GestureDetector(
                  onTap: () => logic.greenPinPopUpShow(),
                  child: Image.asset(
                    'assets/images/Group 98.png',
                    height: 72,
                  ),
                ),
              ),
              logic.filterResultMapPins == true
                  ? Positioned(
                      left: Get.width * 0.32,
                      top: Get.height * 0.145,
                      child: Image.asset(
                        'assets/images/Group 100.png',
                        height: 72,
                      ),
                    )
                  : const SizedBox(),
              logic.filterResultMapPins == true
                  ? Positioned(
                      right: Get.width * 0.18,
                      top: Get.height * 0.21,
                      child: Image.asset(
                        'assets/images/purplepin.png',
                        height: 72,
                      ),
                    )
                  : const SizedBox(),
              logic.filterResultMapPins == true
                  ? Positioned(
                      right: Get.width * 0.22,
                      top: Get.height * 0.325,
                      child: GestureDetector(
                        onTap: () => logic.bluePinShowPopup(),
                        child: Image.asset(
                          'assets/images/Group 99.png',
                          height: 72,
                        ),
                      ),
                    )
                  : const SizedBox(),
              logic.bluePinPopup == true
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => const PetsProfile()),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            color: kPrimaryColor,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              width: Get.width,
                              height: 120,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.asset(
                                        'assets/images/download 1.png',
                                        fit: BoxFit.cover,
                                        height: Get.height,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              MyText(
                                                text: 'Отдам питомца',
                                                color: kSkyBlueColor,
                                                size: 12,
                                                weight: FontWeight.w700,
                                                fontFamily: 'Roboto',
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    logic.hideBluePinPopUp(),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: kDarkGreyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  MyText(
                                                    text: 'Тип питомца: ',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    weight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                  MyText(
                                                    text: 'Кошка',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  MyText(
                                                    text: 'Пол: ',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    weight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                  MyText(
                                                    text: 'Неизвестен',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  MyText(
                                                    text: 'Порода: ',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    weight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                  MyText(
                                                    text: 'Бенгал',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      MyText(
                                                        text: 'Окрас: ',
                                                        color: kDarkGreyColor,
                                                        size: 12,
                                                        weight: FontWeight.w700,
                                                        fontFamily: 'Roboto',
                                                      ),
                                                      MyText(
                                                        text: 'Нет',
                                                        color: kDarkGreyColor,
                                                        size: 12,
                                                        fontFamily: 'Roboto',
                                                      ),
                                                    ],
                                                  ),
                                                  MyText(
                                                    text: 'Маршрут',
                                                    size: 12,
                                                    weight: FontWeight.w600,
                                                    color: kSecondaryColor,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              logic.greenPinPopUp == true
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => const PetsProfile()),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            color: kPrimaryColor,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              width: Get.width,
                              height: 120,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.asset(
                                        'assets/images/Depositphotos_278797182_ds 1.png',
                                        fit: BoxFit.cover,
                                        height: Get.height,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              MyText(
                                                text: 'Вы создали объявление',
                                                color: kGreenColor,
                                                size: 12,
                                                weight: FontWeight.w700,
                                                fontFamily: 'Roboto',
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  logic.hideGreenPinPopUp();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: kDarkGreyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  MyText(
                                                    text: 'Тип питомца: ',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    weight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                  MyText(
                                                    text: 'Собака',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  MyText(
                                                    text: 'Пол: ',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    weight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                  MyText(
                                                    text: 'Неизвестен',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  MyText(
                                                    text: 'Порода: ',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    weight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                  MyText(
                                                    text: 'Бигль',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  MyText(
                                                    text: 'Окрас: ',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    weight: FontWeight.w700,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                  MyText(
                                                    text: 'Нет',
                                                    color: kDarkGreyColor,
                                                    size: 12,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
