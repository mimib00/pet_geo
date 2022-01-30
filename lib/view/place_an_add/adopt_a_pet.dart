import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/place_an_add/place_an_add_widget.dart';

class AdoptAPet extends StatelessWidget {
  const AdoptAPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlaceAnAddWidget(
        payment: true,
        categoryColor: kSecondaryColor,
        categoryName: 'adopt_title'.tr,
        onTap: () => Get.off(
              () => BottomNavBar(
                currentIndex: 3,
              ),
            ));
  }
}
