import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/filter/filter.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/search_box.dart';

// ignore: must_be_immutable
class SpecificPost extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool? showBluePin, showGreenPin,showGreyPin;
  VoidCallback? bluePinOnTap;

  SpecificPost({Key? key,
    this.showGreenPin = false,
    this.showBluePin = false,
    this.showGreyPin = false,
    this.bluePinOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (logic) {
        return Scaffold(
          key: _key,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 142,
            leading: Center(
              child: GestureDetector(
                onTap: () => _key.currentState!.openDrawer(),
                child: Image.asset(
                  'assets/images/Logo PG.png',
                  height: 35,
                  color: kPrimaryColor,
                ),
              ),
            ),
            title: ColorFiltered(
              colorFilter:
              const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
              child: textLogo(24),
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () => Get.off(
                        () => BottomNavBar(
                      currentIndex: 3,
                    ),
                  ),
                  child: Image.asset(
                    logic.search == true
                        ? 'assets/images/Vector (16).png'
                        : 'assets/images/Serach.png',
                    height: logic.search == true ? 23 : 37,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: logic.search == true ? 20 : 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _key.currentState!.openEndDrawer(),
                    child: Image.asset(
                      'assets/images/Filter.png',
                      height: 37,
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size(0, 0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    'assets/images/back_button.png',
                    height: 35,
                  ),
                ),
                minLeadingWidth: 70.0,
              ),
            ),
          ),
          endDrawer: Filter(
            onTap: () => logic.showFilterResults(true),
          ),
          drawer: const MyDrawer(),
          body: Stack(
            children: [
              Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset(
                        'assets/images/IFFfTVE9CMQ 1 (1).png',
                        width: Get.width,
                        height: Get.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    showGreenPin == true
                        ? Positioned(
                      left: Get.width * 0.160,
                      top: Get.height * 0.2,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Image.asset(
                          'assets/images/Group 98.png',
                          height: 72,
                        ),
                      ),
                    )
                        : const SizedBox(),
                    showBluePin == true
                        ? Positioned(
                      right: Get.width * 0.22,
                      top: Get.height * 0.325,
                      child: GestureDetector(
                        onTap: bluePinOnTap ?? () => Get.back(),
                        child: Image.asset(
                          'assets/images/Group 99.png',
                          height: 72,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
              ),
              logic.search == true
                  ? SearchBox(
                hintText: 'Что хотите найти?',
              )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
