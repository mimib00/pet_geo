import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/events_feed/events_feed.dart';
import 'package:pet_geo/view/favorites/favorites.dart';
import 'package:pet_geo/view/map/map_page_main.dart';
import 'package:pet_geo/view/place_an_add/place_an_add.dart';
import 'package:pet_geo/view/user/user.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  var currentIndex = 0;
  bool? guestUser;

  BottomNavBar({
    Key? key,
    this.currentIndex = 0,
    this.guestUser = false,
  }) : super(key: key);

  List<Widget> screens = [
    const EventsFeed(),
    Favorites(),
    const PlaceAnAdd(),
    MapPageMain(),
  ];

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final AuthController authController = Get.find<AuthController>();
  @override
  // void initState() {
  //   if (authController.user.value!.name.isEmpty) {
  //     Get.defaultDialog(
  //       title: "Enter User Information",
  //       titlePadding: EdgeInsets.zero,
  //       content: const Text(
  //         "Loading...",
  //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //       ),
  //     );
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: widget.screens[widget.currentIndex],
      bottomNavigationBar: Stack(
        children: [
          SizedBox(
            height: 65,
            child: BottomNavigationBar(
              currentIndex: widget.currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xffF2F2F2),
              selectedItemColor: kSecondaryColor,
              unselectedItemColor: kDarkGreyColor,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              onTap: (index) {
                setState(() {
                  widget.currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      'assets/images/Favorite.png',
                      height: 25,
                      color: widget.currentIndex == 0 ? kSecondaryColor : kDarkGreyColor,
                    ),
                  ),
                  label: 'События',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      'assets/images/Vector (16).png',
                      height: 25,
                      color: widget.currentIndex == 1 ? kSecondaryColor : kDarkGreyColor,
                    ),
                  ),
                  label: 'Избранное',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      'assets/images/Add Logo.png',
                      height: 25,
                      color: widget.currentIndex == 2 ? kSecondaryColor : kDarkGreyColor,
                    ),
                  ),
                  label: 'Добавить',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      'assets/images/Map Logo.png',
                      height: 25,
                      color: widget.currentIndex == 3 ? kSecondaryColor : kDarkGreyColor,
                    ),
                  ),
                  label: 'map_title'.tr,
                ),
              ],
            ),
          ),
          widget.guestUser == true
              ? GestureDetector(
                  onTap: () => Get.offAll(() => const Authentication()),
                  child: SizedBox(
                    height: 65,
                    width: Get.width,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
