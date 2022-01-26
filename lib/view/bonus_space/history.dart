import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import 'history_tabs/accrual_of_bonuses.dart';
import 'history_tabs/writing_off_bonuses.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
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

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final List tabLabels = [
    'Начисление',
    'Списание',
  ];
  final List<Widget> tabItems = [
    const AccrualOfBonuses(),
    const WritingOfBonuses(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'История',
        globalKey: _key,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      tabs: tabLabels
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
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: tabItems.map((e) => e).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class HistoryTiles extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var title, subtitle;

  HistoryTiles({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        title: MyText(
          text: '$title',
          size: 18,
          weight: FontWeight.w700,
          fontFamily: 'Roboto',
          color: kDarkGreyColor,
          paddingBottom: 15.0,
        ),
        subtitle: MyText(
          text: '$subtitle',
          size: 15,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
        trailing: Wrap(
          spacing: 10.0,
          children: [
            MyText(
              text: '0',
              size: 18,
              weight: FontWeight.w700,
              color: kSecondaryColor,
              fontFamily: 'Roboto',
            ),
            Image.asset(
              'assets/images/Charity 3.png',
              height: 27,
            ),
          ],
        ),
      ),
    );
  }
}
