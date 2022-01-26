import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/user/sign_up.dart';
import 'package:pet_geo/view/widget/logo.dart';

import 'login.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with SingleTickerProviderStateMixin {
  final MapController _mapController = Get.put(MapController());
  late TabController _tabController;
  var currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: currentTab);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
        _mapController.filterResultMapPins = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        toolbarHeight: 100,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo PG.png',
              height: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            ColorFiltered(
              colorFilter: const ColorFilter.mode(kSecondaryColor, BlendMode.srcIn),
              child: textLogo(28),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    'assets/images/Close .png',
                    height: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                      tabs: const [
                        Text(
                          'Уже есть аккаунт',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Хочу зарегистрироваться',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                Login(),
                SignUp(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
