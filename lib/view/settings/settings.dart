import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/about_us/about_us.dart';
import 'package:pet_geo/view/about_us/privacy_policy/privacy_policy.dart';
import 'package:pet_geo/view/about_us/terms_and_conditions/terms_and_conditions.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/bottom_sheets/delete_account.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/language/language.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:pet_geo/view/settings/profile_settings.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import 'change_password.dart';
import 'notification_settings.dart';

class Settings extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        onBackButtonOnTap: () => Get.offAll(() => BottomNavBar()),
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'settings_title'.tr,
        globalKey: _key,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        children: [
          SettingsTiles(
            title: 'Сменить пароль',
            onTap: () => Get.to(() => ChangePassword()),
          ),
          SettingsTiles(
            title: 'Данные',
            onTap: () => Get.to(() => const ProfileSettings()),
          ),
          SettingsTiles(
            title: 'Уведомления',
            onTap: () => Get.to(() => const NotificationSettings()),
          ),
          SettingsTiles(
            title: 'Работа приложения',
            onTap: () => Get.to(() => OnBoardingScreen(
                  status: false,
                )),
          ),
          SettingsTiles(
            title: 'О нас',
            onTap: () => Get.to(() => AboutUs()),
          ),
          SettingsTiles(
            title: 'Рейтинг приложения',
            onTap: () {},
          ),
          SettingsTiles(
            title: 'Техподдержка',
            onTap: () {},
          ),
          SettingsTiles(
            title: 'Пользовательское соглашение',
            onTap: () => Get.to(() => TermsAndConditions()),
          ),
          SettingsTiles(
            title: 'Политика безопасности',
            onTap: () => Get.to(() => PrivacyPolicy()),
          ),
          SettingsTiles(
            title: 'settings_language'.tr,
            onTap: () => Get.to(() => const Language()),
          ),
          SettingsTiles(
            title: 'Удалить аккаунт',
            onTap: () => Get.bottomSheet(
              const DeleteAccount(),
              backgroundColor: kPrimaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              enableDrag: true,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingsTiles extends StatelessWidget {
  SettingsTiles({
    Key? key,
    this.onTap,
    this.title,
  }) : super(key: key);

  VoidCallback? onTap;
  // ignore: prefer_typing_uninitialized_variables
  var title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kInputBorderColor.withOpacity(0.3),
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: MyText(
          text: '$title',
          size: 15,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: kInputBorderColor,
        ),
      ),
    );
  }
}
