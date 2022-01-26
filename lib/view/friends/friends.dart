import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/friends_controller/friends_controller.dart';
import 'package:pet_geo/view/chat/chat_screen.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/search_box.dart';

class Friends extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      init: FriendsController(),
      builder: (logic) {
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: true,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () => logic.showSearch(),
            title: 'Друзья',
            globalKey: _key,
          ),
          body: Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.only(
                    top: logic.search == true ? 60 : 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: logic.getFriendsModel.length,
                itemBuilder: (context, index) {
                  var data = logic.getFriendsModel[index];
                  return FriendTiles(
                    name: data.name,
                  );
                },
              ),
              logic.search == true
                  ? SearchBox(
                      hintText: 'Поиск',
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class FriendTiles extends StatelessWidget {
  FriendTiles({
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
        onTap: () {},
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
              height: 18,color: kPrimaryColor,
            ),
          ),
        ),
        title: MyText(
          text: 'Леонид Белов',
          size: 12,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
        trailing: GestureDetector(
          onTap: () => Get.to(() => const ChatScreen()),
          child: Image.asset(
            'assets/images/msg.png',
            height: 15,
          ),
        ),
      ),
    );
  }
}
