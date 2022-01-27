import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/animal_communities/animal_communities.dart';
import 'package:pet_geo/view/bonus_space/bonus_space.dart';
import 'package:pet_geo/view/bottom_sheets/logout.dart';
import 'package:pet_geo/view/chat/chat_head.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/friends/friends.dart';
import 'package:pet_geo/view/notifications/notifications.dart';
import 'package:pet_geo/view/pets_profile/add_new_pet_profile.dart';
import 'package:pet_geo/view/pets_profile/pets_profile.dart';
import 'package:pet_geo/view/qr/choose_to_pay.dart';
import 'package:pet_geo/view/settings/settings.dart';
import 'package:pet_geo/view/user_profile/user_profile_from_drawer.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

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
            onTap: () => Get.to(() => const UserProfileFromDrawer()),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/People PH.png',
                height: 47,
                width: 47,
                fit: BoxFit.cover,
              ),
            ),
            title: MyText(
              text: 'Иван Иванов',
              size: 15,
              color: kDarkGreyColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Wrap(
              spacing: 10.0,
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => const PetsProfile()),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/pexels-pixabay-33287 1.png',
                      height: 39,
                      width: 39,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/pexels-dominika-roseclay-2023384 1.png',
                    height: 39,
                    width: 39,
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/Untitled.png',
                    height: 39,
                    width: 39,
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: GestureDetector(
                    onTap: () => Get.to(() => const AddNewPetsProfile()),
                    child: Image.asset(
                      'assets/images/New Pet.png',
                      height: 39,
                      width: 39,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          DrawerTiles(
            icon: 'assets/images/Mail.png',
            iconSize: 30,
            title: 'Сообщения',
            onTap: () => Get.to(() => ChatHead()),
          ),
          DrawerTiles(
            icon: 'assets/images/Friends.png',
            iconSize: 32,
            title: 'Друзья',
            onTap: () => Get.to(() => Friends()),
          ),
          DrawerTiles(
            icon: 'assets/images/Notification.png',
            iconSize: 32,
            title: 'Уведомления',
            onTap: () => Get.to(() => Notifications()),
          ),
          DrawerTiles(
            icon: 'assets/images/Community.png',
            iconSize: 32,
            title: 'Сообщества',
            onTap: () => Get.to(() => AnimalCommunities()),
          ),
          DrawerTiles(
            icon: 'assets/images/Charity.png',
            iconSize: 24,
            title: 'Бонусный кабинет',
            onTap: () => Get.to(() => BonusSpace()),
          ),
          DrawerTiles(
            icon: 'assets/images/QR.png',
            iconSize: 32,
            title: 'QR-код',
            onTap: () => Get.to(() => ChooseToPay()),
          ),
          DrawerTiles(
            icon: 'assets/images/Setting.png',
            iconSize: 32,
            title: 'Настройки',
            onTap: () => Get.to(() => Settings()),
          ),
          const SizedBox(
            height: 60,
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 40, top: 8, bottom: 5),
            onTap: () => Get.bottomSheet(
              Logout(),
              backgroundColor: kPrimaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              enableDrag: true,
            ),
            leading: Image.asset(
              'assets/images/Exit.png',
              height: 32,
            ),
            title: MyText(
              text: 'Выход из\nаккаунта',
              size: 15,
              weight: FontWeight.w700,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(
            height: 60,
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

  DrawerTiles({
    Key? key,
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
          weight: FontWeight.w700,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
