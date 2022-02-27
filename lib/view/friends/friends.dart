import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/chat_controller/chat_controller.dart';
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
              print(snapshot.data);
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
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.to(() => ChatScreen(user: user));
          },
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
      },
    );
  }
}
