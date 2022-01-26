import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/user_profile/user_profile_profile_image/comment_on_profile_image/comment_on_profile_image.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  bool? showOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: showOptions == true
          ? AppBar(
              centerTitle: true,
              backgroundColor: kDarkGreyColor,
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
                    onTap: () => Get.bottomSheet(
                      ProfileImageBottomSheet(),
                      backgroundColor: kPrimaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      enableDrag: true,
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () => setState(() {
                showOptions = true;
              }),
              child: Image.asset(
                'assets/images/profile.png',
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: showOptions == true ? 3 : 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  showOptions == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/dark_grey_border_Heart.png',
                                  height: 25,
                                  color: kPrimaryColor,
                                ),
                                MyText(
                                  text: '55',
                                  paddingLeft: 12.0,
                                  size: 16,
                                  fontFamily: 'Roboto',
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Get.to(()=> const CommentOnProfileImage()),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/comment.png',
                                    height: 25,
                                    color: kPrimaryColor,
                                  ),
                                  MyText(
                                    text: '1',
                                    paddingLeft: 12.0,
                                    size: 16,
                                    fontFamily: 'Roboto',
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/images/share.png',
                              height: 25,
                              color: kPrimaryColor,
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileImageBottomSheet extends StatelessWidget {
  List option = [
    'Скачать',
  ];

  ProfileImageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 15, top: 15),
        itemBuilder: (context, index) => ListTile(
          onTap: () => Get.back(),
          title: Center(
            child: MyText(
              size: 15,
              color: kDarkGreyColor,
              text: option[index],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: kLightGreyColor,
        ),
        itemCount: option.length,
      ),
    );
  }
}