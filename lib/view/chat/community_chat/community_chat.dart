import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/user_profile/user_profile_with_offer_help.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/send_box.dart';

class CommunityChat extends StatefulWidget {
  const CommunityChat({Key? key}) : super(key: key);

  @override
  State<CommunityChat> createState() => _CommunityChatState();
}

class _CommunityChatState extends State<CommunityChat> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
        title: 'Чат',
        globalKey: _key,
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              CommentsTiles(
                personImage: 'assets/images/profile.png',
                comment: 'А есть девочки?',
                time: '1 ч.',
              ),
              CommentsTiles(
                personImage: 'assets/images/profile.png',
                comment: 'Да, осталась 1',
                time: '20 мин.',
              ),
            ],
          ),
          SendBox(
            hintText: 'Напишите сообщение',
          ),
        ],
      ),
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
