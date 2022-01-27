import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/chat_controller/chat_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/search_box.dart';
import 'chat_screen.dart';

class ChatHead extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  ChatHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (logic) {
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: true,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () => logic.showSearch(),
            title: 'Сообщения',
            globalKey: _key,
          ),
          body: Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.only(top: logic.search == true ? 70 : 0),
                physics: const BouncingScrollPhysics(),
                itemCount: logic.getChatHeadModel.length,
                itemBuilder: (context, index) {
                  var data = logic.getChatHeadModel[index];
                  return ChatHeadTiles(
                    name: data.name,
                    msg: data.msg,
                    time: data.time,
                    haveNewMsg: data.haveNewMsg,
                    msgCounter: data.msgCounter,
                  );
                },
              ),
              logic.search == true
                  ? SearchBox(
                      hintText: 'Поиск по именам или сообщениям',
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
class ChatHeadTiles extends StatelessWidget {
  ChatHeadTiles({
    Key? key,
    this.haveNewMsg,
    this.msgCounter,
    this.name,
    this.msg,
    this.time,
  }) : super(key: key);

  final bool? haveNewMsg;
  final bool? msgCounter;
  // ignore: prefer_typing_uninitialized_variables
  var name, msg, time;

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
        onTap: () => Get.to(() => const ChatScreen()),
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
          weight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),
        subtitle: RichText(
          text: const TextSpan(
              style: TextStyle(
                fontSize: 10,
                color: kDarkGreyColor,
                fontFamily: 'Roboto',
              ),
              children: [
                TextSpan(
                  text: 'Хорошо',
                ),
                TextSpan(
                  text: '   5 мин.',
                  style: TextStyle(
                    fontSize: 10,
                    color: kInputBorderColor,
                    fontFamily: 'Roboto',
                  ),
                ),
              ]),
        ),
        trailing: haveNewMsg == true
            ? Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondaryColor,
                ),
              )
            : msgCounter == true
                ? Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kSecondaryColor,
                    ),
                    child: Center(
                      child: MyText(
                        text: '2',
                        size: 12,
                        weight: FontWeight.w500,
                        color: kPrimaryColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }
}
