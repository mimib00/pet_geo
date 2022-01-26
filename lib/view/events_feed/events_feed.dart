import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/filter/filter.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/search_box.dart';

import 'grid_view_type.dart';
import 'list_view_type.dart';

class EventsFeed extends StatefulWidget {
  const EventsFeed({Key? key}) : super(key: key);

  @override
  State<EventsFeed> createState() => _EventsFeedState();
}

class _EventsFeedState extends State<EventsFeed>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _key,
          drawer: const MyDrawer(),
          endDrawer: Filter(),
          appBar: AppBar(
            toolbarHeight: logic.storiesHandler == true ? null : 140,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding:
                  EdgeInsets.only(top: logic.storiesHandler == true ? 0 : 20),
              child: Center(
                child: GestureDetector(
                  onTap: () => _key.currentState!.openDrawer(),
                  child: Image.asset(
                    'assets/images/Logo PG.png',
                    height: 35,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            title: Padding(
              padding:
                  EdgeInsets.only(top: logic.storiesHandler == true ? 0 : 20),
              child: ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                child: textLogo(24),
              ),
            ),
            actions: [
              Padding(
                padding:
                    EdgeInsets.only(top: logic.storiesHandler == true ? 0 : 20),
                child: Center(
                  child: GestureDetector(
                    onTap: () => logic.showListView(),
                    child: Image.asset(
                      logic.listView == true
                          ? 'assets/images/grid_view.png'
                          : 'assets/images/list_view.png',
                      height: 22,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 15,
                    left: 20,
                    top: logic.storiesHandler == true ? 0 : 20),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _key.currentState!.openEndDrawer(),
                    child: Image.asset(
                      'assets/images/Filter.png',
                      height: 35,
                    ),
                  ),
                ),
              ),
            ],
            bottom: logic.storiesHandler == true
                ? const PreferredSize(
                    child: SizedBox(),
                    preferredSize: Size(0, 0),
                  )
                : PreferredSize(
                    preferredSize: const Size(0, 0),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      leading: GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => BottomNavBar(
                              currentIndex: 0,
                            ),
                          );
                          logic.showStories();
                        },
                        child: Image.asset(
                          'assets/images/back_button.png',
                          height: 35,
                        ),
                      ),
                      minLeadingWidth: 70.0,
                    ),
                  ),
          ),
          body: GetBuilder<EventsFeedController>(
            init: EventsFeedController(),
            builder: (logic) {
              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: logic.storiesHandler == true ? 65 : 10,
                    ),
                    child: logic.listView == true
                        ? const ListViewType()
                        : const GridViewType(),
                  ),
                  logic.storiesHandler == true
                      ? SearchBox(
                          hintText: 'Что хотите найти?',
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
