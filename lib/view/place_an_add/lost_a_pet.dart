import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/place_an_add/place_an_add_widget.dart';

class LostAPet extends StatelessWidget {
  const LostAPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlaceAnAddWidget(
      categoryColor: kRedColor,
      categoryName: 'lost_pet_title'.tr,
      onTap: () => Get.off(
        () => BottomNavBar(
          currentIndex: 3,
        ),
      ),
    );
  }
}
