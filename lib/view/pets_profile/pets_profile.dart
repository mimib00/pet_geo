import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_geo/model/pet_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/filter/filter.dart';
import 'package:pet_geo/view/map/specific_post.dart';
import 'package:pet_geo/view/user_profile/user_profile_with_offer_help.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class PetsProfile extends StatefulWidget {
  final Pet? pet;
  const PetsProfile({
    Key? key,
    this.pet,
  }) : super(key: key);

  @override
  State<PetsProfile> createState() => _PetsProfileState();
}

class _PetsProfileState extends State<PetsProfile> with SingleTickerProviderStateMixin {
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

  bool? save = false;

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
                text: widget.pet!.name.toUpperCase(),
                size: 18,
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                align: TextAlign.center,
              ),
            ),
            trailing: Wrap(
              spacing: 5.0,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/Filter.png',
                    height: 30,
                  ),
                ),
              ],
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
              height: 325,
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    elevation: 0,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        SizedBox(
                          height: 180,
                          width: Get.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => Get.to(
                                () => SpecificPost(
                                  showGreenPin: true,
                                ),
                              ),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(widget.pet!.location["lat"], widget.pet!.location["long"]),
                                  zoom: 14.4746,
                                ),
                                markers: {
                                  Marker(
                                    markerId: MarkerId(widget.pet!.id!),
                                    position: LatLng(widget.pet!.location["lat"], widget.pet!.location["long"]),
                                    consumeTapEvents: true,
                                  ),
                                },
                                zoomControlsEnabled: false,
                                scrollGesturesEnabled: false,
                                rotateGesturesEnabled: false,
                                zoomGesturesEnabled: false,
                                tiltGesturesEnabled: false,
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(180),
                                child: CachedNetworkImage(
                                  imageUrl: widget.pet!.photoUrl,
                                  placeholder: (conxt, url) => Image.asset(
                                    'assets/images/Pet.png',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 6,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: widget.pet!.gender == "male_title" ? Colors.lightBlue : Colors.pink,
                                  borderRadius: BorderRadius.circular(180),
                                ),
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
                      height: 90,
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
                                        text: 'year_title'.tr,
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      MyText(
                                        text: widget.pet!.birthYear,
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
                                        text: 'weight_title'.tr,
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      MyText(
                                        text: "${widget.pet!.weight} " + "kg_title".tr,
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
                                        text: 'color_title'.tr,
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      MyText(
                                        text: widget.pet!.color,
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
                                        text: 'sterilization_title'.tr,
                                        size: 12,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Roboto',
                                        color: kDarkGreyColor,
                                        paddingRight: 15,
                                      ),
                                      MyText(
                                        text: widget.pet!.sterilization ? "yes_title".tr : "no_title".tr,
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
                    height: 5,
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
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
                                    onTap: () => Get.to(
                                      () => UserProfileWithOferHelp(),
                                    ),
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
                  Tab2(),
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

// ignore: must_be_immutable
class Tab2 extends StatelessWidget {
  List images = [
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
    'assets/images/pexels-simona-kidrič-2607544 1.png',
    'assets/images/pexels-pixabay-33287 1.png',
  ];

  Tab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        GridView.builder(
          itemCount: images.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          physics: const ClampingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 100,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) => Image.asset(
            images[index],
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
