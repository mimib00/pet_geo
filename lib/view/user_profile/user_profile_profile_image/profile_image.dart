import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ProfileImage extends StatefulWidget {
  final String photo;
  const ProfileImage({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
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
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: CachedNetworkImage(
          imageUrl: widget.photo,
        ),
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
