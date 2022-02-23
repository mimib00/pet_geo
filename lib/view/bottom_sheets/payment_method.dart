import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/place_an_add_controller/place_an_add_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class PaymentMethod extends StatelessWidget {
  PaymentMethod({Key? key}) : super(key: key);

  final PlaceAnAdController controller = Get.put<PlaceAnAdController>(PlaceAnAdController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        itemBuilder: (context, index) => ListTile(
          onTap: () => {
            controller.selectPayment(index),
            Get.back()
          },
          title: Center(
            child: MyText(
              size: 15,
              color: kDarkGreyColor,
              text: controller.typesOfPaymentMethods[index],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: kLightGreyColor,
        ),
        itemCount: controller.typesOfPaymentMethods.length,
      ),
    );
  }
}
