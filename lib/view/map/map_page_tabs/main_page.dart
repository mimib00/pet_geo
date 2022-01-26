import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';

import 'tabs/all.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: currentTab);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
  }

  List tabs = [
    'Все',
    'Избранное',
  ];

  final List tabItems = [
    const All(),
    const All(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (logic) {
        return Column(
          children: [
            Container(
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 2,
                  color: kLightGreyColor,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: TabBar(
                  onTap: (index) {
                    index == 0 ? logic.showFilterResults(false) : logic.hideFilterResults();
                  },
                  controller: _tabController,
                  labelColor: kPrimaryColor,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: kDarkGreyColor,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: currentTab == 0 ? const Radius.circular(50) : Radius.zero,
                      bottomLeft: currentTab == 0 ? const Radius.circular(50) : Radius.zero,
                      topRight: currentTab == 1 ? const Radius.circular(50) : Radius.zero,
                      bottomRight: currentTab == 1 ? const Radius.circular(50) : Radius.zero,
                    ),
                    color: kSecondaryColor,
                  ),
                  tabs: const [
                    Text(
                      'Все',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Избранное',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: tabItems
                    .map(
                      (e) => SizedBox(
                        child: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
