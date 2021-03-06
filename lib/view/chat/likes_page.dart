import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class LikesPage extends StatelessWidget {
  final List likes;
  LikesPage({
    Key? key,
    required this.likes,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      builder: (controller) {
        AuthController authController = Get.find<AuthController>();
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: true,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () {},
            title: "Likes",
            globalKey: _key,
          ),
          body: Stack(children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: likes.length,
              itemBuilder: (context, index) {
                return FutureBuilder<Users?>(
                  future: controller.getLikeOwner(likes[index]),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return UserMessageTile(
                      user: snapshot.data!,
                      itsMe: authController.user.value!.id == snapshot.data!.id,
                    );
                  },
                );
              },
            ),
          ]),
        );
      },
    );
  }
}

class UserMessageTile extends StatelessWidget {
  final Users user;
  final bool itsMe;
  const UserMessageTile({
    Key? key,
    required this.user,
    this.itsMe = false,
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
          trailing: Visibility(
            visible: !itsMe,
            child: Image.asset('assets/images/msg.png', height: 20),
          ),
        ),
      ),
    );
  }
}

// // ignore: must_be_immutable
// class Messages extends StatelessWidget {
//   // ignore: prefer_typing_uninitialized_variables
//   var title;

//   Messages({Key? key,
//     this.title,
//   }) : super(key: key);

//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CommunityController>(
//       init: CommunityController(),
//       builder: (logic) {
//         return Scaffold(
//           key: _key,
//           drawer: const MyDrawer(),
//           appBar: CustomAppBar2(
//             haveSearch: true,
//             haveTitle: true,
//             onTitleTap: () {},
//             showSearch: () => logic.showSearch(),
//             title: title,
//             globalKey: _key,
//           ),
//           body: Stack(
//             children: [
//               ListView.builder(
//                 padding: EdgeInsets.only(
//                     top: logic.search == true ? 70 : 10, bottom: 10),
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: logic.msgs.length,
//                 itemBuilder: (context, index) {
//                   var data = logic.getMessagesModel[index];
//                   return MessagesTiles(
//                     name: data.name,
//                     add: data.add,
//                   );
//                 },
//               ),
//               logic.search == true
//                   ? SearchBox(
//                       hintText: '??????????',
//                     )
//                   : const SizedBox(),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // ignore: must_be_immutable
// class MessagesTiles extends StatelessWidget {
//   MessagesTiles({
//     Key? key,
//     this.name,
//     this.add = false,
//   }) : super(key: key);

//   // ignore: prefer_typing_uninitialized_variables
//   var name;
//   bool? add;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: kInputBorderColor.withOpacity(0.3),
//           ),
//         ),
//       ),
//       child: ListTile(
//         onTap: () {},
//         contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//         leading: Container(
//           width: 37,
//           height: 37,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xffc4c4c4),
//           ),
//           child: Center(
//             child: Image.asset(
//               'assets/images/Group 30.png',
//               height: 18,
//               color: kPrimaryColor,
//             ),
//           ),
//         ),
//         title: MyText(
//           text: '???????????? ??????????',
//           size: 12,
//           color: kDarkGreyColor,
//           fontFamily: 'Roboto',
//         ),
//         trailing: add == true
//             ? GestureDetector(
//                 onTap: () {},
//                 child: Image.asset(
//                   'assets/images/fill follow.png',
//                   height: 35,
//                 ),
//               )
//             : GestureDetector(
//                 onTap: () => Get.to(() => const ChatScreen()),
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: Image.asset(
//                     'assets/images/msg.png',
//                     height: 15,
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
