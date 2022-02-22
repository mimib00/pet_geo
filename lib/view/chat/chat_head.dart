import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/chat_controller/chat_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/chat/chat_screen.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Inbox extends StatelessWidget {
  Inbox({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: true,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'Inbox',
        globalKey: _key,
      ),
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.getChats(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return Container();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.docs;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var temp = data[index].data();
                  var tempTime = temp["time"];
                  if (tempTime == null) return Container();
                  DateTime time = tempTime.toDate();
                  List users = temp["users"];
                  var sender = users.firstWhere(
                    (element) => element != FirebaseFirestore.instance.collection("users").doc(authController.user.value!.id),
                  );

                  return ChatHead(
                    msg: temp["last_message"],
                    time: "${time.hour}:${time.minute}",
                    sender: sender,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatHead extends StatelessWidget {
  final String msg, time;
  final DocumentReference<Map<String, dynamic>> sender;
  const ChatHead({
    Key? key,
    required this.msg,
    required this.time,
    required this.sender,
  }) : super(key: key);

  Future<Users?> getSender() async {
    var user = await sender.get();
    if (user.data() == null) return null;
    return Users.fromMap(user.data()!, id: user.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users?>(
      future: getSender(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return Container();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var user = snapshot.data!;
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
              subtitle: Row(
                children: [
                  MyText(
                    text: msg,
                    size: 12,
                    fontFamily: 'Roboto',
                  ),
                  const SizedBox(width: 10),
                  MyText(
                    text: time,
                    size: 12,
                    color: kInputBorderColor,
                    fontFamily: 'Roboto',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// // ignore: must_be_immutable
// class ChatHeadTiles extends StatelessWidget {
//   ChatHeadTiles({
//     Key? key,
//     this.haveNewMsg,
//     this.msgCounter,
//     this.name,
//     this.msg,
//     this.time,
//   }) : super(key: key);

//   final bool? haveNewMsg;
//   final bool? msgCounter;
//   // ignore: prefer_typing_uninitialized_variables
//   var name, msg, time;

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
//         onTap: () => Get.to(() => ChatScreen()),
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
//           text: 'Леонид Белов',
//           size: 12,
//           color: kDarkGreyColor,
//           weight: FontWeight.w500,
//           fontFamily: 'Roboto',
//         ),
//         subtitle: RichText(
//           text: const TextSpan(
//               style: TextStyle(
//                 fontSize: 10,
//                 color: kDarkGreyColor,
//                 fontFamily: 'Roboto',
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Хорошо',
//                 ),
//                 TextSpan(
//                   text: '   5 мин.',
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: kInputBorderColor,
//                     fontFamily: 'Roboto',
//                   ),
//                 ),
//               ]),
//         ),
//         trailing: haveNewMsg == true
//             ? Container(
//                 width: 9,
//                 height: 9,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: kSecondaryColor,
//                 ),
//               )
//             : msgCounter == true
//                 ? Container(
//                     width: 16,
//                     height: 16,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: kSecondaryColor,
//                     ),
//                     child: Center(
//                       child: MyText(
//                         text: '2',
//                         size: 12,
//                         weight: FontWeight.w500,
//                         color: kPrimaryColor,
//                         fontFamily: 'Roboto',
//                       ),
//                     ),
//                   )
//                 : const SizedBox(),
//       ),
//     );
//   }
// }
