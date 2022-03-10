import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/community_controller/community_contoller.dart';
import 'package:pet_geo/model/community_model.dart';
import 'package:pet_geo/view/chat/likes_page.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/bottom_sheets/turn_on_notifications.dart';
import 'package:pet_geo/view/chat/community_chat/community_chat.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/mod_drawer.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/likes/likes.dart';
import 'package:pet_geo/view/widget/community_picture.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class PetNewsCommunityProfile extends StatefulWidget {
  final Community community;
  const PetNewsCommunityProfile({
    Key? key,
    required this.community,
  }) : super(key: key);

  @override
  State<PetNewsCommunityProfile> createState() => _PetNewsCommunityProfileState();
}

class _PetNewsCommunityProfileState extends State<PetNewsCommunityProfile> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: currentIndex);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
  }

  bool? follow = false;

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
            minLeadingWidth: 105.0,
            title: GestureDetector(
              onTap: () {},
              child: MyText(
                paddingRight: 35.0,
                text: widget.community.name,
                size: 18,
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                align: TextAlign.center,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10.0,
                  children: [
                    GestureDetector(
                      onTap: () => Get.bottomSheet(
                        TurnOnNotifications(),
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
                        'assets/images/Notificationwhite.png',
                        height: 35,
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
                        color: kPrimaryColor,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ],
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
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.community.cover,
                                    height: 150,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 65,
                              bottom: 60,
                              child: BorderedText(
                                strokeWidth: 2.0,
                                strokeColor: kBlackColor,
                                child: Text(
                                  widget.community.description,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
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
                                              GestureDetector(
                                                onTap: () => Get.to(() => LikesPage(likes: const [])),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/Friends.png',
                                                      height: 30,
                                                    ),
                                                    MyText(
                                                      text: widget.community.followers.length,
                                                      size: 19,
                                                      weight: FontWeight.w700,
                                                      color: kSecondaryColor,
                                                      paddingLeft: 10.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    follow = !follow!;
                                                  });
                                                },
                                                child: Image.asset(
                                                  follow == true ? 'assets/images/fill follow.png' : 'assets/images/emptyFollow.png',
                                                  height: 35,
                                                  color: kDarkGreyColor,
                                                ),
                                              )
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
                                  color: kGreenColor,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CommunityPicture(
                                community: widget.community,
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
                              onTap: () => Get.to(() => CommunityChat(id: widget.community.id)),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height,
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Tab1(
                    id: widget.community.id,
                  ),
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
  final String id;
  Tab1({
    Key? key,
    required this.id,
  }) : super(key: key);

  final CollectionReference<Map<String, dynamic>> _postRef = FirebaseFirestore.instance.collection("posts");

  post(Map<String, dynamic> data) async {
    try {
      // post to firestore
      var snap = await _postRef.add(data);

      var poster = await snap.get();

      if (!poster.exists) throw "Post doesn't exists";

      // add to user list
      DocumentReference<Map<String, dynamic>> temp = data['owner'];
      temp.update({
        "posts": FieldValue.arrayUnion(
          [
            _postRef.doc(poster.id)
          ],
        )
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        // Card(
        //   margin: const EdgeInsets.symmetric(
        //     horizontal: 5,
        //   ),
        //   elevation: 0,
        //   child: Container(
        //     height: 56,
        //     margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        //     child: Center(
        //       child: TextField(
        //         cursorColor: kInputBorderColor.withOpacity(0.5),
        //         decoration: InputDecoration(
        //           contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        //           enabledBorder: const OutlineInputBorder(
        //             borderSide: BorderSide(
        //               color: kLightGreyColor,
        //               width: 2.0,
        //             ),
        //           ),
        //           focusedBorder: const OutlineInputBorder(
        //             borderSide: BorderSide(
        //               color: kLightGreyColor,
        //               width: 2.0,
        //             ),
        //           ),
        //           hintText: 'Есть о чем рассказать?',
        //           hintStyle: TextStyle(
        //             fontSize: 12,
        //             fontFamily: 'Roboto',
        //             color: kInputBorderColor.withOpacity(0.5),
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Card(
          margin: const EdgeInsets.all(5),
          elevation: 0,
          child: Container(
            height: 56,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Center(
              child: TextField(
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    // post to firestore
                    Map<String, dynamic> data = {
                      "caption": value,
                      "owner": FirebaseFirestore.instance.collection("communities").doc(id),
                      "likes": [],
                      "comments": [],
                      "created_at": FieldValue.serverTimestamp()
                    };

                    post(data);
                  }
                },
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
                  hintText: 'What\'s on your mind?',
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
        Expanded(
          child: GetBuilder<CommunityController>(
            init: CommunityController(),
            builder: (controller) {
              return FutureBuilder(
                future: controller.getCommunityPosts(id),
                builder: (context, snapshot) => const PostWidget(),
              );
            },
          ),
        ),
        // ListView.builder(
        //   itemCount: 1,
        //   shrinkWrap: true,
        //   physics: const ClampingScrollPhysics(),
        //   itemBuilder: (context, index) => const PostWidget(),
        // )
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

class PetNewsScreen extends StatefulWidget {
  const PetNewsScreen({Key? key}) : super(key: key);

  @override
  State<PetNewsScreen> createState() => _PetNewsScreenState();
}

class _PetNewsScreenState extends State<PetNewsScreen> with SingleTickerProviderStateMixin {
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

  bool? follow = false;

  Future<Community?> getPetNewsCommunity() async {
    var news = await FirebaseFirestore.instance.collection("communities").doc('PetNews').get();

    if (!news.exists) return null;
    return Community(
      news.id,
      news.data()!['name'],
      news.data()!['description'],
      news.data()!['photo'],
      news.data()!['cover'],
      news.data()!['followers'],
      news.data()!['mods'],
      news.data()!['blocked'],
      news.data()!['owner'],
      news.data()!['type'],
    );
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
            minLeadingWidth: 105.0,
            title: GestureDetector(
              onTap: () {},
              child: MyText(
                paddingRight: 35.0,
                text: 'PetNews',
                size: 18,
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                align: TextAlign.center,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10.0,
                  children: [
                    GestureDetector(
                      onTap: () => Get.bottomSheet(
                        TurnOnNotifications(),
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
                        'assets/images/Notificationwhite.png',
                        height: 35,
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
                        color: kPrimaryColor,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<Community?>(
          future: getPetNewsCommunity(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return Container();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
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
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          'assets/images/pexels-photo-5745219 1.png',
                                          height: 150,
                                          width: Get.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 65,
                                    bottom: 60,
                                    child: BorderedText(
                                      strokeWidth: 2.0,
                                      strokeColor: kBlackColor,
                                      child: const Text(
                                        'Ваш мир домашних животных',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                                    GestureDetector(
                                                      onTap: () => Get.to(() => LikesPage(likes: const [])),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/Friends.png',
                                                            height: 30,
                                                          ),
                                                          MyText(
                                                            text: snapshot.data!.followers.length,
                                                            size: 19,
                                                            weight: FontWeight.w700,
                                                            color: kSecondaryColor,
                                                            paddingLeft: 10.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          follow = !follow!;
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        follow == true ? 'assets/images/fill follow.png' : 'assets/images/emptyFollow.png',
                                                        height: 35,
                                                        color: kDarkGreyColor,
                                                      ),
                                                    )
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
                                        color: kGreenColor,
                                        width: 3.0,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          'assets/images/Depositphotos_250473480_ds 1.png',
                                          height: Get.height,
                                        ),
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
                    height: Get.height,
                    child: TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //  Tab1(),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
