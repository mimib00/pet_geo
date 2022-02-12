import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/map/list_page_tabs/tabs/everything.dart';
import 'package:pet_geo/view/map/list_page_tabs/tabs/favorites.dart';

class ListPageMain extends StatefulWidget {
  const ListPageMain({Key? key}) : super(key: key);

  @override
  State<ListPageMain> createState() => _ListPageMainState();
}

class _ListPageMainState extends State<ListPageMain> with SingleTickerProviderStateMixin {
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
    'all_title'.tr,
    'fav_title'.tr,
  ];

  final List tabItems = [
    const Everything(),
    const Favorites(),
  ];

  @override
  Widget build(BuildContext context) {
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
              tabs: tabs
                  .map(
                    (e) => Text(
                      e,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                  .toList(),
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
  }
}
