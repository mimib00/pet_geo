import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_sheets/bottom_sheet_for_mod.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/chat/community_chat/community_chat.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/mod_drawer.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/likes/likes.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class PetGeoExecutiveProfile extends StatefulWidget {
  const PetGeoExecutiveProfile({Key? key}) : super(key: key);

  @override
  State<PetGeoExecutiveProfile> createState() => _PetGeoExecutiveProfileState();
}

class _PetGeoExecutiveProfileState extends State<PetGeoExecutiveProfile> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: currentIndex);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      drawer: const MyDrawer(),
      endDrawer: const ModDrawer(),
      appBar: AppBar(
        toolbarHeight: 140,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: GestureDetector(
              onTap: () => _key.currentState!.openDrawer(),
              child: Image.asset(
                'assets/images/Logo PG.png',
                height: 35,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
            child: textLogo(24),
          ),
        ),
        actions: const [
          SizedBox()
        ],
        bottom: PreferredSize(
          preferredSize: const Size(0, 0),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(
                'assets/images/back_button.png',
                height: 35,
              ),
            ),
            minLeadingWidth: 70.0,
            title: GestureDetector(
              onTap: () {},
              child: MyText(
                paddingRight: 35.0,
                text: 'Собаки МО',
                size: 18,
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                align: TextAlign.center,
              ),
            ),
            trailing: GestureDetector(
              // onTap: () => _key.currentState!.openEndDrawer(),
              child: Image.asset(
                'assets/images/Filter.png',
                height: 30,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: kLightGreyColor,
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: 265,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SizedBox(
                        height: 200,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(color: kInputBorderColor, borderRadius: BorderRadius.circular(5)),
                                height: 150,
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.topCenter,
                            //   child: Padding(
                            //     padding:
                            //     const EdgeInsets.symmetric(horizontal: 5),
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(5),
                            //       child: Image.asset(
                            //         'assets/images/pexels-photo-5745219 1.png',
                            //         height: 150,
                            //         width: Get.width,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 15,
                                            bottom: 5,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Friends.png',
                                                    height: 30,
                                                  ),
                                                  MyText(
                                                    text: '0',
                                                    size: 19,
                                                    weight: FontWeight.w700,
                                                    color: kSecondaryColor,
                                                    paddingLeft: 10.0,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 15, bottom: 10),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                border: Border.all(
                                  color: kLightGreyColor,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/Group 30.png',
                                  height: 45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: SizedBox(
                      height: 40,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: TabBar(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          controller: tabController,
                          isScrollable: true,
                          indicatorColor: kPrimaryColor,
                          tabs: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              height: 27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: currentIndex == 0 ? kSecondaryColor : kPrimaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/Burger.png',
                                    height: 12,
                                    color: currentIndex == 0 ? kPrimaryColor : kDarkGreyColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MyText(
                                    text: 'Новости',
                                    size: 12,
                                    paddingRight: 5,
                                    weight: FontWeight.w500,
                                    color: currentIndex == 0 ? kPrimaryColor : kDarkGreyColor,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const CommunityChat()),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 10.0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                height: 27,
                                // width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: currentIndex == 1 ? kSecondaryColor : kPrimaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/msg.png',
                                      height: 15,
                                      color: currentIndex == 1 ? kPrimaryColor : kDarkGreyColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    MyText(
                                      text: 'Чат',
                                      size: 12,
                                      paddingRight: 5,
                                      weight: FontWeight.w500,
                                      color: currentIndex == 1 ? kPrimaryColor : kDarkGreyColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              height: 27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: currentIndex == 2 ? kSecondaryColor : kPrimaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/Icon PH.png',
                                    height: 25,
                                    color: currentIndex == 2 ? kPrimaryColor : kDarkGreyColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MyText(
                                    text: 'Фото',
                                    size: 12,
                                    paddingRight: 5,
                                    weight: FontWeight.w500,
                                    color: currentIndex == 2 ? kPrimaryColor : kDarkGreyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.5,
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const Tab1(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  const Tab1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          elevation: 0,
          child: Container(
            height: 56,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Center(
              child: TextField(
                cursorColor: kInputBorderColor.withOpacity(0.5),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kLightGreyColor,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kLightGreyColor,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Есть о чем рассказать? ',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    color: kInputBorderColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        Card(
          elevation: 0,
          child: SizedBox(
            width: 173,
            height: 61,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: 'Ваша лента пуста',
                  size: 12,
                  color: kDarkGreyColor,
                  weight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
                const SizedBox(
                  height: 5.0,
                ),
                MyText(
                  text: 'Надо что-то добавить',
                  size: 12,
                  color: kInputBorderColor,
                  fontFamily: 'Roboto',
                ),
              ],
            ),
          ),
        ),
        Container(),
      ],
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
  }) : super(key: key);

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
              trailing: GestureDetector(
                onTap: () => Get.bottomSheet(
                  BottomSheetForMod(),
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
                  color: kDarkGreyColor,
                  size: 30,
                ),
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
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/download 1.png',
                height: 300,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
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
                  'assets/images/Save.png',
                  height: 30,
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
