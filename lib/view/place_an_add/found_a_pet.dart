import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/map/map_page_main.dart';
import 'package:pet_geo/view/place_an_add/place_an_add_widget.dart';

// ignore: must_be_immutable
class FoundAPet extends StatelessWidget {
  bool? guestUser;

  FoundAPet({Key? key,
    this.guestUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (mapController) {
        return PlaceAnAddWidget(
          categoryColor: kGreenColor,
          categoryName: 'Нашёл питомца',
          onTap: () {
            if (guestUser == true) {
              Get.to(
                () => MapPageMain(
                  guestUser: guestUser,
                ),
              );
            } else {
              Get.to(
                () => BottomNavBar(
                  currentIndex: 3,
                ),
              );
            }
            mapController.hideFilterResults();
          },
        );
      },
    );
  }
}
