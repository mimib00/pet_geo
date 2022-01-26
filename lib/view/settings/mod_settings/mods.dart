import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/settings_controller/mod_settings_controller.dart';
import 'package:pet_geo/view/bottom_sheets/remove_from_mod.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/search_box.dart';

class Mods extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   Mods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ModSettingsController>(
      init: ModSettingsController(),
      builder: (logic) {
        return Scaffold(
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
                colorFilter:
                    const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                child: textLogo(24),
              ),
            ),
            actions: const [SizedBox()],
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
                minLeadingWidth: logic.search == true ? 100 : 70.0,
                title: GestureDetector(
                  onTap: () {},
                  child: MyText(
                    paddingRight: 35.0,
                    text: 'Модераторы',
                    size: 18,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    align: TextAlign.center,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () => logic.showSearch(),
                  child: logic.search == true
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
                              text: 'Готово',
                              size: 12,
                              fontFamily: 'Roboto',
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      : Image.asset(
                          'assets/images/Serach.png',
                          height: 35,
                        ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              logic.search == true
                  ? const CommunityMembers()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: logic.getSettingsModel.length,
                      itemBuilder: (context, index) {
                        var data = logic.getSettingsModel[index];
                        return ModsTiles(
                          title: data.title,
                        );
                      },
                    ),
              logic.search == true
                  ? SearchBox(
                      hintText: 'Поиск',
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ModsTiles extends StatelessWidget {
  ModsTiles({
    Key? key,
    this.title,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kInputBorderColor.withOpacity(0.3),
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        onTap: () {},
        leading: Container(
          width: 37,
          height: 37,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffc4c4c4),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/Group 30.png',
              height: 18,
              color: kPrimaryColor,
            ),
          ),
        ),
        title: MyText(
          text: '$title',
          size: 12,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
        trailing: GestureDetector(
          child: Image.asset(
            'assets/images/Filter.png',
            height: 25,
            color: kDarkGreyColor,
          ),
        ),
      ),
    );
  }
}

class CommunityMembers extends StatefulWidget {
  const CommunityMembers({Key? key}) : super(key: key);

  @override
  State<CommunityMembers> createState() => _CommunityMembersState();
}

class _CommunityMembersState extends State<CommunityMembers> {
  // ignore: prefer_typing_uninitialized_variables
  var selectedValue;
  List communityMembers = [
    'Леонид Белов',
    'Лиана Высоцкая',
    'Ксения  Урывина',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ModSettingsController>(
        init: ModSettingsController(),
        builder: (logic) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20, top: 60),
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                setState(() {
                  selectedValue = communityMembers[index];
                });
                Get.bottomSheet(
                  RemoveFromMod(
                    onTap: () => logic.hideSearch(),
                  ),
                  backgroundColor: kPrimaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  enableDrag: true,
                );
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              leading: Container(
                width: 37,
                height: 37,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc4c4c4),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/Group 30.png',
                    height: 18,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              title: MyText(
                size: 12,
                fontFamily: 'Roboto',
                color: kDarkGreyColor,
                text: '${communityMembers[index]}',
              ),
              trailing: Radio(
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = communityMembers[index];
                  });
                },
                value: communityMembers[index].toString(),
                activeColor: kSecondaryColor,
              ),
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: kLightGreyColor,
            ),
            itemCount: communityMembers.length,
          );
        });
  }
}
