import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: Get.locale == const Locale("en") ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    var lang = GetStorage().read("lang");
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'settings_language'.tr,
        globalKey: _key,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                  onTap: (index) async {
                    final box = GetStorage();
                    if (index == 0) {
                      Get.updateLocale(const Locale("en"));
                      box.write("lang", "en");
                    } else {
                      Get.updateLocale(const Locale("ru"));
                      box.write("lang", "ru");
                    }
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
                      topLeft: lang == "en" ? const Radius.circular(50) : Radius.zero,
                      bottomLeft: lang == "en" ? const Radius.circular(50) : Radius.zero,
                      topRight: lang == "ru" ? const Radius.circular(50) : Radius.zero,
                      bottomRight: lang == "ru" ? const Radius.circular(50) : Radius.zero,
                    ),
                    color: kSecondaryColor,
                  ),
                  tabs: [
                    Text(
                      'english'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'russian'.tr,
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
    );
  }
}
