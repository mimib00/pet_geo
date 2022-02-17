import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/chat/community_chat/community_chat.dart';
import 'package:pet_geo/view/chat/likes_page.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/send_box.dart';

class CommentOnProfileImage extends StatefulWidget {
  const CommentOnProfileImage({Key? key}) : super(key: key);

  @override
  State<CommentOnProfileImage> createState() => _CommentOnProfileImageState();
}

class _CommentOnProfileImageState extends State<CommentOnProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(
                'assets/images/back_button.png',
                height: 35,
              ),
            ),
          ],
        ),
        title: MyText(
          text: '1 из 7',
          size: 18,
          fontFamily: 'Roboto',
          color: kPrimaryColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: const Icon(
                Icons.more_horiz,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              ListTile(
                onTap: () {},
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 42,
                    width: 42,
                    fit: BoxFit.cover,
                  ),
                ),
                title: MyText(
                  text: 'Леонид Белов',
                  size: 12,
                  weight: FontWeight.w700,
                  color: kDarkGreyColor,
                  fontFamily: 'Roboto',
                ),
                subtitle: MyText(
                  text: '17 янв в 15:00',
                  size: 12,
                  color: kInputBorderColor,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 385,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/profile.png',
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 15,
                  bottom: 15,
                  right: 15,
                ),
                child: Wrap(
                  spacing: 22.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/filled_heart.png',
                      height: 20,
                    ),
                    GestureDetector(
                      // onTap: () => Get.to(() => Comments()),
                      child: Image.asset(
                        'assets/images/comment.png',
                        height: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.bottomSheet(
                        const Share(),
                        backgroundColor: kPrimaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        enableDrag: true,
                      ),
                      child: Image.asset(
                        'assets/images/share.png',
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => LikesPage(likes: const [])),
                child: MyText(
                  text: 'Нравится: 55',
                  size: 12,
                  weight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  color: kDarkGreyColor,
                  paddingLeft: 15,
                ),
              ),
              CommentsTiles(
                personImage: 'assets/images/People PH.png',
                comment: 'Классная фотография',
                time: '1 ч.',
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 85,
                width: Get.width,
                color: kPrimaryColor,
                child: Center(
                  child: SendBox(
                    hintText: 'Напишите комментарий',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
