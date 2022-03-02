import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/community_controller/community_contoller.dart';
import 'package:pet_geo/view/animal_communities/tabs/create_animal_community.dart';
import 'package:pet_geo/view/animal_communities/tabs/create_shelter.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/pet_geo_executive_profile/pet_geo_executive_profile.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class CreateShelterMoreDetails extends StatefulWidget {
  const CreateShelterMoreDetails({Key? key}) : super(key: key);

  @override
  State<CreateShelterMoreDetails> createState() => _CreateShelterMoreDetailsState();
}

class _CreateShelterMoreDetailsState extends State<CreateShelterMoreDetails> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  var currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: currentTab);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
  }

  final List tabLabels = [
    'Приют',
    'Сообщество',
  ];
  final List<Widget> tabItems = [
    const CreateShelter(),
    CreateAnimalCommunity(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
      init: CommunityController(),
      builder: (logic) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: false,
            haveTitle: true,
            title: 'Создание',
            addCustomTitle: true,
            onTitleTap: () {},
            globalKey: _key,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 8,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Fields(
                      hintText: 'Организационно-правовая форма',
                    ),
                    Fields(
                      hintText: 'юридический адрес',
                    ),
                    Fields(
                      hintText: 'Фактический адрес',
                    ),
                    Fields(
                      hintText: 'ИНН',
                    ),
                    Fields(
                      hintText: 'КПП',
                    ),
                    Fields(
                      hintText: 'наименование банка',
                    ),
                    Fields(
                      hintText: 'руководитель',
                    ),
                    Fields(
                      hintText: 'электронная почта',
                    ),
                    Fields(
                      hintText: 'сайт приюта',
                    ),
                    MyText(
                      text: 'Лица, уполномоченные от имени приюта осуществлять сбор пожертвований',
                      size: 15,
                      fontFamily: 'Roboto',
                      color: kDarkGreyColor,
                      paddingTop: 10.0,
                      paddingBottom: 15.0,
                    ),
                    Fields(
                      hintText: 'ФИО',
                    ),
                    Fields(
                      hintText: 'Номер телефона',
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: Get.width * 0.45,
                        child: MyButton(
                          text: 'Добавить',
                          height: 36,
                          radius: 5.0,
                          textSize: 13,
                          weight: FontWeight.w700,
                          textColor: kPrimaryColor,
                          btnBgColor: kInputBorderColor,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: SizedBox(
                    width: Get.width * 0.78,
                    child: MyButton(
                      text: 'Создать приют',
                      textSize: 16,
                      weight: FontWeight.w700,
                      btnBgColor: kSecondaryColor,
                      height: 47,
                      radius: 12.0,
                      onPressed: () {
                        Get.to(() => const PetGeoExecutiveProfile());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class Fields extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var hintText;
  TextEditingController? textEditingController;

  Fields({
    Key? key,
    this.hintText,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextField(
        controller: textEditingController,
        cursorColor: kDarkGreyColor,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: kDarkGreyColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: '$hintText'.toUpperCase(),
          hintStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: kDarkGreyColor,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kInputBorderColor,
              width: 1.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kInputBorderColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
