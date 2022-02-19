import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/friends_controller/friends_controller.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/chat/chat_screen.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Friends extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      init: FriendsController(),
      builder: (controller) {
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: true,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () {},
            title: 'Friends',
            globalKey: _key,
          ),

          body: FutureBuilder<List<Users>>(
            future: controller.getFriends(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return Container();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var friend = snapshot.data![index];
                  return FriendTile(user: friend);
                },
              );
            },
          ),
          // body: Stack(
          //   children: [
          //     ListView.builder(
          //       padding: const EdgeInsets.only(top: 10, bottom: 10),
          //       physics: const BouncingScrollPhysics(),
          //       itemCount: 0,
          //       itemBuilder: (context, index) {
          //         return Container();
          //       },
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}

class FriendTile extends StatelessWidget {
  final Users user;
  const FriendTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kInputBorderColor.withOpacity(0.3),
            ),
          ),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(180),
            child: CachedNetworkImage(
              imageUrl: user.photoUrl,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          title: MyText(
            text: user.name,
            size: 12,
            color: kDarkGreyColor,
            fontFamily: 'Roboto',
          ),
          trailing: Image.asset('assets/images/msg.png', height: 20),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FriendTiles extends StatelessWidget {
  final Users user;
  const FriendTiles({
    Key? key,
    required this.user,
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
              height: 18,
              color: kPrimaryColor,
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
