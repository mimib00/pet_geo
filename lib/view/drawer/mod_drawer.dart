import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/settings/mod_settings/black_list.dart';
import 'package:pet_geo/view/settings/mod_settings/information.dart';
import 'package:pet_geo/view/settings/mod_settings/members_settings.dart';
import 'package:pet_geo/view/settings/mod_settings/mod_notifications.dart';
import 'package:pet_geo/view/settings/mod_settings/mods.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ModDrawer extends StatelessWidget {
  const ModDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 30),
        children: [
          const SizedBox(
            height: 40,
          ),
          ListTile(
            onTap: () => Get.back(),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/Back.png',
                height: 47,
                width: 47,
                fit: BoxFit.cover,
              ),
            ),
            title: MyText(
              text: 'Настройки',
              size: 18,
              fontFamily: 'Roboto',
              color: kDarkGreyColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DrawerTiles(
            icon: 'assets/images/Icon Info.png',
            iconSize: 28,
            title: 'Информация',
            onTap: () => Get.to(() => Information()),
          ),
          DrawerTiles(
            icon: 'assets/images/mod.png',
            iconSize: 20,
            title: 'Модераторы',
            onTap: () => Get.to(() => Mods()),
          ),
          DrawerTiles(
            icon: 'assets/images/CommunityPersons.png',
            iconSize: 18,
            title: 'Участники',
            onTap: () => Get.to(() => ModMembersSettings()),
          ),
          DrawerTiles(
            icon: 'assets/images/Icon Setting.png',
            iconSize: 25,
            title: 'Черный список',
            onTap: () => Get.to(() => BlackList()),
          ),
          DrawerTiles(
            icon: 'assets/images/notify.png',
            iconSize: 22,
            title: 'Уведомления',
            onTap: () => Get.to(() => const ModNotifications()),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawerTiles extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var icon, title;
  double? iconSize;
  VoidCallback? onTap;

  DrawerTiles({Key? key,
    this.icon,
    this.title,
    this.iconSize = 15.0,
    this.onTap,
  }) : super(key: key);

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
        contentPadding: const EdgeInsets.only(left: 40, top: 8, bottom: 5),
        onTap: onTap,
        leading: Image.asset(
          '$icon',
          height: iconSize,
        ),
        title: MyText(
          text: '$title',
          size: 15,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
