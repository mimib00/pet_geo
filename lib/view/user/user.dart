import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/user/sign_up.dart';
import 'package:pet_geo/view/widget/logo.dart';

import 'login.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> with SingleTickerProviderStateMixin {
  // final MapController _mapController = Get.put(MapController());
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
                  height: 40,
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
                      onTap: (index) {
                        setState(() {
                          currentTab = index;
                        });
                      },
                      tabs: [
                        Text(
                          'login_title'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "register_title".tr,
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
              children: [
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
