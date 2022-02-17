import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/notifications_controller/notifications_controller.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/friend_requests/request_response.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class FriendRequests extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  FriendRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      builder: (controller) {
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: false,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () {},
            title: 'Requests',
            globalKey: _key,
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.requests.length,
            itemBuilder: (context, index) {
              return FriendRequestTiles(
                user: controller.requests[index],
                controller: controller,
              );
            },
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class FriendRequestTiles extends StatelessWidget {
  final Users user;
  final NotificationsController controller;
  const FriendRequestTiles({
    Key? key,
    required this.user,
    required this.controller,
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
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        leading: SizedBox(
          width: 47,
          height: 47,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: user.photoUrl,
                fit: BoxFit.cover,
                width: 47,
                height: 47,
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/People PH.png',
                    height: 37,
                    width: 37,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: MyText(
          text: user.name,
          size: 15,
          fontFamily: 'Roboto',
          color: kDarkGreyColor,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: [
                GestureDetector(
                  onTap: () => controller.acceptRequest(user),
                  child: Container(
                    width: 66,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kSecondaryColor,
                    ),
                    child: Center(
                      child: MyText(
                        text: 'Accept',
                        size: 10,
                        weight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => controller.declineRequest(user),
                  child: Container(
                    width: 66,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kInputBorderColor,
                    ),
                    child: Center(
                      child: MyText(
                        text: 'Decline',
                        size: 10,
                        weight: FontWeight.w700,
                        color: kPrimaryColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
