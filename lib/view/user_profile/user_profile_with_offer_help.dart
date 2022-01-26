import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/animal_communities/animal_communities.dart';
import 'package:pet_geo/view/chat/messages.dart';
import 'package:pet_geo/view/bottom_sheets/options_for_user_profile.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/filter/filter.dart';
import 'package:pet_geo/view/offer_help/offer_help.dart';
import 'package:pet_geo/view/user_profile/user_profile_profile_image/profile_image.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';

// ignore: must_be_immutable
class UserProfileWithOferHelp extends StatefulWidget {
  bool? haveSecondTab;

  UserProfileWithOferHelp({
    Key? key,
    this.haveSecondTab = false,
  }) : super(key: key);

  @override
  State<UserProfileWithOferHelp> createState() => _UserProfileWithOferHelpState();
}

class _UserProfileWithOferHelpState extends State<UserProfileWithOferHelp> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List petImages = [
    'assets/images/Depositphotos_3549727_xl-2015 1.png',
    'assets/images/Depositphotos_37645053_ds 1.png',
    'assets/images/Depositphotos_278797182_ds 1.png',
    'assets/images/Depositphotos_28583659_ds 1.png',
    'assets/images/Depositphotos_37645053_ds 1.png',
  ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      drawer: const MyDrawer(),
      endDrawer: Filter(),
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
                text: 'Иван Иванов',
                size: 18,
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                align: TextAlign.center,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => Get.bottomSheet(
                OptionsForUserProfile(),
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
                'assets/images/Settings.png',
                height: 35,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: kLightGreyColor,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          itemCount: petImages.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => Get.back(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      petImages[index],
                                      height: 79,
                                      width: 79,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 40),
                        child: Row(
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
                                  top: 45,
                                  right: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Get.to(
                                        () => Messages(
                                          title: 'Друзья',
                                        ),
                                      ),
                                      child: Row(
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
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.to(() => AnimalCommunities()),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/Community.png',
                                            height: 30,
                                          ),
                                          MyText(
                                            text: '2',
                                            size: 19,
                                            weight: FontWeight.w700,
                                            color: kSecondaryColor,
                                            paddingLeft: 10.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    MyButton(
                                      onPressed: () => Get.to(() => const OfferHelp()),
                                      text: 'Помочь',
                                      textSize: 12,
                                      weight: FontWeight.w500,
                                      btnBgColor: kSecondaryColor,
                                      height: 30,
                                      textColor: kPrimaryColor,
                                      radius: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const ProfileImage()),
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, top: 30),
                          height: 100,
                          width: 100,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/images/profile.png',
                                height: Get.height,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: 27,
                          width: 82,
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
                              MyText(
                                text: 'Лента',
                                size: 12,
                                paddingRight: 5,
                                weight: FontWeight.w500,
                                color: currentIndex == 0 ? kPrimaryColor : kDarkGreyColor,
                              ),
                            ],
                          ),
                        ),
                        Container(),
                        // widget.haveSecondTab == true
                        //     ? Container(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 8.0),
                        //         height: 27,
                        //         width: 100,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(5),
                        //           color: currentIndex == 1
                        //               ? kSecondaryColor
                        //               : kPrimaryColor,
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             Image.asset(
                        //               'assets/images/help.png',
                        //               height: 17,
                        //               color: currentIndex == 1
                        //                   ? kPrimaryColor
                        //                   : kDarkGreyColor,
                        //             ),
                        //             MyText(
                        //               text: 'Обо мне',
                        //               size: 12,
                        //               weight: FontWeight.w500,
                        //               color: currentIndex == 1
                        //                   ? kPrimaryColor
                        //                   : kDarkGreyColor,
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const Tab1(),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
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
            vertical: 5,
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
