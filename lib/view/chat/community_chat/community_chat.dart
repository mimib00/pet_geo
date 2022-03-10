import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/chat/chat_screen.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class CommunityChat extends StatefulWidget {
  final String id;
  const CommunityChat({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  State<CommunityChat> createState() => _CommunityChatState();
}

class _CommunityChatState extends State<CommunityChat> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");

  final AuthController authController = Get.find<AuthController>();

  Stream<QuerySnapshot<Map<String, dynamic>>> getChat() {
    return FirebaseFirestore.instance.collection("communities").doc(widget.id).collection('chat').snapshots();
  }

  sendMessage() async {
    var user = authController.user.value!;

    Map<String, dynamic> data = {
      "msg": controller.text.trim(),
      "sender": _userRef.doc(user.id),
      "time": FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection("communities").doc(widget.id).collection('chat').add(data);
  }

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
        title: 'Чат',
        globalKey: _key,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getChat(),
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
                      isSent: temp["sender"] != FirebaseFirestore.instance.collection("users").doc(authController.user.value!.id),
                      sender: temp["sender"],
                    );
                  },
                );
              },
            ),
          ),
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
                          sendMessage();
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
      // body: Stack(
      //   children: [
      //     ListView(
      //       physics: const BouncingScrollPhysics(),
      //       children: [
      //         CommentsTiles(
      //           personImage: 'assets/images/profile.png',
      //           comment: 'А есть девочки?',
      //           time: '1 ч.',
      //         ),
      //         CommentsTiles(
      //           personImage: 'assets/images/profile.png',
      //           comment: 'Да, осталась 1',
      //           time: '20 мин.',
      //         ),
      //       ],
      //     ),
      //     SendBox(
      //       hintText: 'Напишите сообщение',
      //     ),
      //   ],
      // ),
    );
  }
}

// ignore: must_be_immutable
class CommentsTiles extends StatelessWidget {
  CommentsTiles({
    Key? key,
    this.personImage,
    this.comment,
    this.time,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var personImage, comment, time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          '$personImage',
          height: 37,
          width: 37,
          fit: BoxFit.cover,
        ),
      ),
      title: MyText(
        text: '$comment',
        size: 12,
        color: kDarkGreyColor,
        fontFamily: 'Roboto',
      ),
      subtitle: MyText(
        text: '$time',
        size: 12,
        color: kInputBorderColor,
        fontFamily: 'Roboto',
      ),
      trailing: MyText(
        text: 'Ответить',
        size: 12,
        color: kInputBorderColor,
        fontFamily: 'Roboto',
        weight: FontWeight.w900,
      ),
    );
  }
}
