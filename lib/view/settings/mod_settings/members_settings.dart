import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/settings_controller/mod_settings_controller.dart';
import 'package:pet_geo/view/bottom_sheets/mod_members_settings.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/search_box.dart';

class ModMembersSettings extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   ModMembersSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ModSettingsController>(
      init: ModSettingsController(),
      builder: (logic) {
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: true,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () => logic.showSearch(),
            title: 'Участники',
            globalKey: _key,
          ),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: logic.search == true ? 60 : 0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: logic.getSettingsModel.length,
                  itemBuilder: (context, index) {
                    var data = logic.getSettingsModel[index];
                    return MembersTiles(
                      title: data.title,
                    );
                  },
                ),
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
class MembersTiles extends StatelessWidget {
  MembersTiles({
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
          onTap: () => Get.bottomSheet(
            ModMembersSettingsBottomSheet(),
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
            'assets/images/Filter.png',
            height: 25,
            color: kDarkGreyColor,
          ),
        ),
      ),
    );
  }
}
