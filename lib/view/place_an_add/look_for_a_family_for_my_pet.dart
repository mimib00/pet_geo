import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/place_an_add/place_an_add_widget.dart';

class LookForAFamilyForMyPet extends StatelessWidget {
  const LookForAFamilyForMyPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (mapController) {
        return PlaceAnAddWidget(
          categoryColor: kSkyBlueColor,
          categoryName: 'family_pet_title'.tr,
          onTap: () => Get.off(
            () => BottomNavBar(
              currentIndex: 3,
            ),
          ),
        );
      },
    );
  }
}
