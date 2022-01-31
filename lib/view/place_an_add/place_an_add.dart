import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/place_an_add_controller/place_an_add_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class PlaceAnAdd extends StatelessWidget {
  const PlaceAnAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: Image.asset(
            'assets/images/Logo PG.png',
            height: 30,
            color: kPrimaryColor,
          ),
        ),
        title: ColorFiltered(
          colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          child: textLogo(24),
        ),
      ),
      body: GetBuilder<PlaceAnAdController>(
        init: PlaceAnAdController(),
        builder: (controller) => Column(
          children: [
            SizedBox(
              height: 80,
              child: Center(
                child: MyText(
                  size: 20,
                  color: kDarkGreyColor,
                  text: 'create_ad_title'.tr,
                  align: TextAlign.center,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: kLightGreyColor,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.addCategory.length,
                itemBuilder: (context, index) => placeAnAddTiles(
                  index,
                  controller.addCategory[index],
                  controller.categoryColor[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget placeAnAddTiles(var index, String title, Color color) {
    return GetBuilder<PlaceAnAdController>(
      builder: (controller) {
        return ListTile(
          tileColor: controller.currentIndex == index ? kSecondaryColor : kPrimaryColor,
          onTap: () {
            controller.currentCategory(index);
          },
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 2.0,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          title: MyText(
            text: title,
            weight: FontWeight.w600,
            size: 18,
            color: controller.currentIndex == index ? kPrimaryColor : kDarkGreyColor,
          ),
        );
      },
    );
  }
}
