import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class NewNotificationsPost extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   NewNotificationsPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: false,
        onTitleTap: () {},
        showSearch: () {},
        globalKey: _key,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: const [
          PostWidget(),
        ],
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // MyText(
        //   text: 'Отдам питомца',
        //   size: 18,
        //   weight: FontWeight.w700,
        //   color: kSecondaryColor,
        //   paddingLeft: 15,
        //   paddingTop: 15,
        // ),
        // MyText(
        //   text: 'Кошка по кличке неизвестно\nКому бенгалов?\nКонтакты',
        //   size: 12,
        //   fontFamily: 'Roboto',
        //   color: kDarkGreyColor,
        //   paddingLeft: 15,
        //   paddingTop: 15,
        // ),
        // MyText(
        //   text: 'Ссылка',
        //   size: 12,
        //   fontFamily: 'Roboto',
        //   color: kSecondaryColor,
        //   paddingLeft: 15,
        //   paddingTop: 10,
        // ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: 353,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/download 1.png',
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 15,
            bottom: 15,
            right: 15,
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 22.0,
                children: [
                  Image.asset(
                    'assets/images/dark_grey_border_Heart.png',
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/comment.png',
                      height: 20,
                    ),
                  ),
                  GestureDetector(
                    // onTap: () => Get.bottomSheet(
                    //   Share(),
                    //   backgroundColor: kPrimaryColor,
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(15),
                    //       topRight: Radius.circular(15),
                    //     ),
                    //   ),
                    //   enableDrag: true,
                    // ),
                    child: Image.asset(
                      'assets/images/share.png',
                      height: 20,
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/Vector (16).png',
                height: 20,
                color: kDarkGreyColor,
              ),
            ],
          ),
        ),
        GestureDetector(
          // onTap: () => Get.to(() => Likes()),
          child: MyText(
            text: 'Нравится: 55',
            size: 12,
            weight: FontWeight.w700,
            fontFamily: 'Roboto',
            color: kDarkGreyColor,
            paddingLeft: 15,
          ),
        ),
        MyText(
          text: 'Посмотреть все комментарии (2)',
          size: 12,
          fontFamily: 'Roboto',
          color: kInputBorderColor,
          paddingLeft: 15.0,
          paddingTop: 10.0,
          paddingBottom: 10.0,
        ),
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/profile.png',
              width: 37,
              height: 37,
              fit: BoxFit.cover,
            ),
          ),
          title: MyText(
            text: 'Добавьте комментарий',
            size: 12,
            color: kInputBorderColor,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
