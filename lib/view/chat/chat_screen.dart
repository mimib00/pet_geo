import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/qr_controller/qr_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/user_profile/user_profile_with_offer_help.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/send_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrController>(
      init: QrController(),
      builder: (logic) {
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
            title: 'Леонид Белов',
            globalKey: _key,
          ),
          body: Stack(
            children: [
              ListView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 85,
                ),
                children: [
                  receiverBox(
                    'Хорошо',
                    '10 мин.',
                  ),
                  senderBox(
                    'Здравствуйте, расскажите какие есть щенки',
                    '10 мин.',
                  ),
                ],
              ),
              SendBox(
                hintText: 'Сообщение',
              ),
            ],
          ),
        );
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

  Widget receiverBox(String msg, time) {
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
                      Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffc4c4c4),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/Group 30.png',
                            height: 16,
                            color: kPrimaryColor,
                          ),
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
