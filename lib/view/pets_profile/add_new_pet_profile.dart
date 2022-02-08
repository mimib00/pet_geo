import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_sheets/camera_options.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class AddNewPetsProfile extends StatefulWidget {
  const AddNewPetsProfile({Key? key}) : super(key: key);

  @override
  State<AddNewPetsProfile> createState() => _AddNewPetsProfileState();
}

class _AddNewPetsProfileState extends State<AddNewPetsProfile> with SingleTickerProviderStateMixin {
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

  bool? save = false, filter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 140,
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
            minLeadingWidth: filter == true ? 100 : 70.0,
            title: GestureDetector(
              onTap: () {},
              child: MyText(
                paddingRight: 35.0,
                text: 'Дружок',
                size: 18,
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                align: TextAlign.center,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  filter = !filter!;
                });
              },
              child: filter == true
                  ? Container(
                      width: 65,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: kPrimaryColor,
                        ),
                      ),
                      child: Center(
                        child: MyText(
                          text: 'ready_title'.tr,
                          size: 12,
                          fontFamily: 'Roboto',
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/images/Filter.png',
                      height: 35,
                    ),
            ),
          ),
        ),
      ),
      body: Container(
        color: kLightGreyColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 5),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: filter == true ? 345.5 : 325,
              child: Column(
                children: [
                  filter == true
                      ? Card(
                          margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                          elevation: 0,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Card(
                                elevation: 0,
                                color: kLightGreyColor,
                                child: SizedBox(
                                  height: 170,
                                  width: Get.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/images/IMG_8247 1.png',
                                      height: Get.height,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      bottom: 3,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        'assets/images/Pet.png',
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6,
                                    right: 0,
                                    child: Image.asset(
                                      'assets/images/Sign.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Card(
                          margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                          elevation: 0,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              GestureDetector(
                                onTap: () => Get.bottomSheet(
                                  CameraOptions(),
                                  backgroundColor: kPrimaryColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  enableDrag: true,
                                ),
                                child: Card(
                                  elevation: 0,
                                  color: kLightGreyColor,
                                  child: SizedBox(
                                    height: 170,
                                    width: Get.width,
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, bottom: 3),
                                    child: GestureDetector(
                                      onTap: () => Get.bottomSheet(
                                        CameraOptions(),
                                        backgroundColor: kPrimaryColor,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        enableDrag: true,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          'assets/images/Pet.png',
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6,
                                    right: 0,
                                    child: Image.asset(
                                      'assets/images/Sign.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    elevation: 0,
                    child: SizedBox(
                      height: filter == true ? 110 : 90,
                      width: Get.width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: 'Год рождения',
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      filter == true
                                          ? FilterTextField(
                                              hintText: '2020 г.',
                                              autoFocus: true,
                                            )
                                          : MyText(
                                              text: '2020 г.',
                                              size: 12,
                                              fontFamily: 'Roboto',
                                              color: kDarkGreyColor,
                                            ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  height: 2,
                                  color: kLightGreyColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: 'Вес',
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      filter == true
                                          ? FilterTextField(
                                              hintText: '5 кг.',
                                            )
                                          : MyText(
                                              text: '5 кг.',
                                              size: 12,
                                              fontFamily: 'Roboto',
                                              color: kDarkGreyColor,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 2,
                            height: Get.height,
                            color: kLightGreyColor,
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: 'Окрас',
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      filter == true
                                          ? FilterTextField(
                                              hintText: 'Бежевый',
                                            )
                                          : MyText(
                                              text: 'Бежевый',
                                              size: 12,
                                              fontFamily: 'Roboto',
                                              color: kDarkGreyColor,
                                            ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  height: 2,
                                  color: kLightGreyColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: 'Стерилизация',
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      filter == true
                                          ? FilterTextField(
                                              hintText: 'Да',
                                            )
                                          : MyText(
                                              text: 'Да',
                                              size: 12,
                                              fontFamily: 'Roboto',
                                              color: kDarkGreyColor,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
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
                                      horizontal: 8.0,
                                    ),
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
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10.0,
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    height: 27,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: currentIndex == 1 ? kSecondaryColor : kPrimaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/Icon PH.png',
                                          height: 25,
                                          color: currentIndex == 1 ? kPrimaryColor : kDarkGreyColor,
                                        ),
                                        MyText(
                                          text: 'Фото',
                                          size: 12,
                                          paddingRight: 5,
                                          weight: FontWeight.w500,
                                          color: currentIndex == 1 ? kPrimaryColor : kDarkGreyColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    // onTap: () => Get.to(() => UserProfile()),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      height: 27,
                                      width: 135,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: currentIndex == 2 ? kSecondaryColor : kPrimaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/images/Icon people.png',
                                            height: 25,
                                            color: currentIndex == 2 ? kPrimaryColor : kDarkGreyColor,
                                          ),
                                          MyText(
                                            text: 'Иван Иванов',
                                            size: 12,
                                            paddingRight: 5,
                                            weight: FontWeight.w500,
                                            color: currentIndex == 2 ? kPrimaryColor : kDarkGreyColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      save = !save!;
                                    });
                                  },
                                  child: Image.asset(
                                    save == true ? 'assets/images/Vector (16).png' : 'assets/images/Save.png',
                                    height: save == true ? 17 : 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

// ignore: must_be_immutable
class FilterTextField extends StatelessWidget {
  FilterTextField({
    Key? key,
    this.hintText,
    this.autoFocus = false,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var hintText;
  bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: autoFocus!,
              cursorColor: kDarkGreyColor,
              style: const TextStyle(
                fontSize: 12,
                color: kSecondaryColor,
                fontFamily: 'Roboto',
              ),
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                hintText: "$hintText",
                hintStyle: const TextStyle(
                  fontSize: 12,
                  color: kSecondaryColor,
                  fontFamily: 'Roboto',
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
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
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kLightGreyColor,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kLightGreyColor,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Есть о чем рассказать? ',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    color: kInputBorderColor.withOpacity(0.5),
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
