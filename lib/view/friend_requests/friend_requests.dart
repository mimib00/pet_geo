import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'Заявки',
        globalKey: _key,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return FriendRequestTiles(
            name: 'Леонид Белов',
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class FriendRequestTiles extends StatelessWidget {
  FriendRequestTiles({
    Key? key,
    this.name,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var name;

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
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => RequestResponse()),
                  child: Container(
                    width: 66,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kSecondaryColor,
                    ),
                    child: Center(
                      child: MyText(
                        text: 'Добавить',
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
                  onTap: () => Get.to(() => RequestResponse()),
                  child: Container(
                    width: 66,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kInputBorderColor,
                    ),
                    child: Center(
                      child: MyText(
                        text: 'Отклонить',
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
