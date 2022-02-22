import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/chat_controller/chat_controller.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/user_profile/user_profile_with_offer_help.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ChatScreen extends StatelessWidget {
  final Users? user;
  ChatScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (user == null) return Container();
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (chat) {
        chat.createChatRoom(user!);
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: false,
            haveTitle: true,
            onTitleTap: () => Get.to(
              () => UserProfileWithOferHelp(
                haveSecondTab: true,
              ),
            ),
            showSearch: () {},
            title: user!.name,
            globalKey: _key,
          ),
          body: Column(
            children: [
              // messages
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: chat.getMessages(user!),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = snapshot.data!.docs;
                    return ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var temp = data[index].data();
                        var tempTime = temp["time"];
                        if (tempTime == null) return Container();
                        DateTime time = tempTime.toDate();

                        return ChatBubble(
                          msg: temp["msg"],
                          time: "${time.hour}:${time.minute}",
                          isSent: temp["sender"] != FirebaseFirestore.instance.collection("users").doc(user!.id),
                          sender: temp["sender"],
                        );
                      },
                    );
                  },
                ),
              ),

              // input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 45,
                    color: kPrimaryColor,
                    child: Center(
                      child: TextField(
                        controller: controller,
                        cursorColor: const Color(0xffBEBEBE),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: kDarkGreyColor,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              chat.sendMessage(user!, controller.text.trim());
                              controller.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff2f2f2),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: 86,
                                  height: 30,
                                  child: Center(
                                    child: MyText(
                                      text: 'Send'.toUpperCase(),
                                      size: 10,
                                      color: kDarkGreyColor,
                                      weight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Message',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Color(0xffBEBEBE),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: kSecondaryColor,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: kSecondaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String msg, time;
  final bool isSent;
  final DocumentReference<Map<String, dynamic>> sender;
  const ChatBubble({
    Key? key,
    required this.msg,
    required this.time,
    required this.isSent,
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
        Widget child = isSent ? senderBox(msg, time) : receiverBox(msg, time, user.photoUrl);

        return child;
      },
    );
  }

  Widget senderBox(String msg, time) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: Get.width * 0.85,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kLightGreyColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: MyText(
                    text: msg,
                    size: 10,
                    fontFamily: 'Roboto',
                    color: kDarkGreyColor,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: MyText(
                    text: time,
                    size: 10,
                    align: TextAlign.right,
                    fontFamily: 'Roboto',
                    color: kInputBorderColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget receiverBox(String msg, time, String photo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: Get.width * 0.5,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: CachedNetworkImage(
                          imageUrl: photo,
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: kLightGreyColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: MyText(
                            text: msg,
                            size: 10,
                            fontFamily: 'Roboto',
                            color: kDarkGreyColor,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: MyText(
                            text: time,
                            size: 10,
                            align: TextAlign.right,
                            fontFamily: 'Roboto',
                            color: kInputBorderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
