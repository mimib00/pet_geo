import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/notifications_controller/notifications_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/friend_requests/friend_requests.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Notifications extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (logic) {
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: false,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () {},
            title: 'Уведомления',
            globalKey: _key,
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: logic.getNotificationModel.length,
            itemBuilder: (context, index) {
              var data = logic.getNotificationModel[index];
              return NotificationsTiles(
                name: data.name,
                time: data.time,
                notificationMsg: data.notificationMsg,
                notificationThing: data.notificationThing,
                haveNewNotification: data.haveNewNotification,
                haveFriendRequest: data.haveFriendRequest,
                onTap: data.onTap,
              );
            },
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class NotificationsTiles extends StatelessWidget {
  NotificationsTiles({
    Key? key,
    this.name,
    this.notificationMsg,
    this.notificationThing,
    this.time,
    this.haveNewNotification = false,
    this.haveFriendRequest = false,
    this.onTap,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var name, notificationMsg, time, notificationThing;
  bool? haveNewNotification, haveFriendRequest;

  VoidCallback? onTap;

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
      child: haveFriendRequest == true
          ? ListTile(
              onTap: () => Get.to(() => FriendRequests()),
              leading: Container(
                width: 37,
                height: 37,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc4c4c4),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/Group 30.png',
                    height: 18,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              title: MyText(
                text: 'Заявки в друзья',
                size: 15,
                fontFamily: 'Roboto',
                color: kDarkGreyColor,
              ),
              subtitle: MyText(
                text: '1 человек',
                size: 10,
                color: kInputBorderColor,
                align: TextAlign.start,
                fontFamily: 'Roboto',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: kInputBorderColor,
              ),
            )
          : ListTile(
              onTap: onTap,
              leading: Container(
                width: 37,
                height: 37,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc4c4c4),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/Group 30.png',
                    height: 18,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 10,
                    color: kDarkGreyColor,
                    fontFamily: 'Roboto',
                  ),
                  children: [
                    TextSpan(
                      text: '$name',
                      style: const TextStyle(
                        fontSize: 12,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: ' $notificationMsg',
                      style: const TextStyle(
                        fontSize: 12,
                        color: kDarkGreyColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: " ${notificationThing ?? ''}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: kSecondaryColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: MyText(
                text: 'Леонид Белов',
                size: 10,
                color: kInputBorderColor,
                fontFamily: 'Roboto',
              ),
              trailing: haveNewNotification == true
                  ? Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor,
                      ),
                    )
                  : const SizedBox(),
            ),
    );
  }
}
