import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/filter/filter.dart';
import 'package:pet_geo/view/user/user.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/search_box.dart';

import 'list_page_tabs/list_page_main.dart';
import 'map_page_tabs/main_page.dart';

// ignore: must_be_immutable
class MapPageMain extends StatelessWidget {
  bool? guestUser;

  MapPageMain({Key? key, this.guestUser = false}) : super(key: key);

  List tabs = [
    'Карта',
    'Список',
  ];

  final List tabItems = [
    const MainPage(),
    const ListPageMain(),
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (logic) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
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
                    onTap: () => logic.showSearch(),
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
                child: TabBar(
                  onTap: (index) {
                    guestUser == true
                        ? Get.offAll(() => const User())
                        : () {};
                  },
                  indicatorColor: kPrimaryColor,
                  indicatorWeight: 5.0,
                  indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 15),
                  labelColor: kPrimaryColor,
                  unselectedLabelColor: kPrimaryColor,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                    fontFamily: 'Roboto',
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                    fontFamily: 'Roboto',
                  ),
                  tabs: tabs
                      .map(
                        (e) => Tab(
                      child: Text(e),
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
            endDrawer: Filter(
              onTap: () => logic.showFilterResults(true),
            ),
            drawer: const MyDrawer(),
            body: Stack(
              children: [
                TabBarView(
                  children: tabItems
                      .map(
                        (e) => SizedBox(
                          child: e,
                        ),
                      )
                      .toList(),
                ),
                logic.search == true
                    ? SearchBox(
                        hintText: 'Что хотите найти?',
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
