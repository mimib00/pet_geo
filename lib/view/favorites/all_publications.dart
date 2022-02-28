import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/folder_model.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/events_feed/list_view_type.dart';
import 'package:pet_geo/view/likes/likes.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class AllPublications extends StatelessWidget {
  final Folder folder;
  const AllPublications({
    Key? key,
    required this.folder,
  }) : super(key: key);

  Future<List<Ad>> getPosts() async {
    List<Ad> ads = [];
    for (var doc in folder.posts) {
      var data = await doc.get();
      var ad = Ad.fromMap(data.data()!);
      ads.add(ad);
    }
    return ads;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(
            'assets/images/back_button.png',
          ),
        ),
        title: ColorFiltered(
          colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          child: textLogo(24),
        ),
      ),
      body: FutureBuilder<List<Ad>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) throw snapshot.error.toString();
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          print(snapshot.data);
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Post(post: snapshot.data![index]);
            },
          );
        },
      ),
    );
    // return GetBuilder<FavoriteController>(
    //   init: FavoriteController(),
    //   builder: (logic) {
    //     return Scaffold(
    // backgroundColor: kLightGreyColor,
    // key: _key,
    // drawer: const MyDrawer(),
    // appBar: CustomAppBar2(
    //   haveSearch: false,
    //   haveTitle: false,
    //   onTitleTap: () {},
    //   showSearch: () {},
    //   globalKey: _key,
    // ),
    //       body: ListView(
    //         shrinkWrap: true,
    //         children: [
    //           Center(
    //             child: MyText(
    //               paddingTop: 15.0,
    //               paddingBottom: 15.0,
    //               text: 'Все публикации',
    //               size: 18,
    //               weight: FontWeight.w700,
    //               color: kDarkGreyColor,
    //             ),
    //           ),
    //           const PostWidget(),
    //         ],
    //       ),
    //     );
    //   },
    // );
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
  var currentIndex = 0;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kInputBorderColor.withOpacity(0.3),
                ),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc4c4c4),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/Group 30.png',
                    height: 20,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              title: MyText(
                text: 'Гость',
                size: 12,
                color: kDarkGreyColor,
                weight: FontWeight.w700,
                fontFamily: 'Roboto',
              ),
              subtitle: MyText(
                text: '17 янв в 15:00',
                size: 12,
                color: kInputBorderColor,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          MyText(
            text: 'Отдам питомца',
            size: 18,
            weight: FontWeight.w700,
            color: kSecondaryColor,
            paddingLeft: 15,
            paddingTop: 15,
          ),
          MyText(
            text: 'Кошка по кличке неизвестно\nКому бенгалов?\nКонтакты',
            size: 12,
            fontFamily: 'Roboto',
            color: kDarkGreyColor,
            paddingLeft: 15,
            paddingTop: 15,
          ),
          MyText(
            text: 'Ссылка',
            size: 12,
            fontFamily: 'Roboto',
            color: kSecondaryColor,
            paddingLeft: 15,
            paddingTop: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: 300,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: 2,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/download 1.png',
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            2,
                            (index) => Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: currentIndex == index ? kPrimaryColor : kPrimaryColor.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                Image.asset(
                  'assets/images/Vector (16).png',
                  height: 20,
                  color: kDarkGreyColor,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(() => Likes()),
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
      ),
    );
  }
}
