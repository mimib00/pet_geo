import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bonus_space/history.dart';
import 'package:pet_geo/view/bonus_space/where_to_spend_vetc_company/where_to_spend_vetc_updated.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/charity_enter_amount_box.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import 'how_to_get_vetc.dart';

class BonusSpace extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  BonusSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'Бонусный кабинет',
        globalKey: _key,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        children: [
          MyText(
            text: 'Участие в благотворительной бонусной программе',
            size: 20,
            color: kDarkGreyColor,
            align: TextAlign.center,
            paddingRight: 15.0,
            paddingLeft: 15.0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: CharityEnterAmountBox(),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kInputBorderColor.withOpacity(0.3),
                ),
              ),
            ),
            child: ListTile(
              onTap: () => Get.to(() => HowToGetVetc()),
              title: Wrap(
                spacing: 5.0,
                children: [
                  MyText(
                    text: 'Как получить',
                    size: 15,
                    color: kDarkGreyColor,
                    fontFamily: 'Roboto',
                  ),
                  MyText(
                    text: 'VETC',
                    size: 15,
                    color: kSecondaryColor,
                    fontFamily: 'Roboto',
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: kInputBorderColor,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kInputBorderColor.withOpacity(0.3),
                ),
              ),
            ),
            child: ListTile(
              onTap: () => Get.to(() => WhereToSpendVetcUpdated()),
              title: Wrap(
                spacing: 5.0,
                children: [
                  MyText(
                    text: 'Где потратить',
                    size: 15,
                    color: kDarkGreyColor,
                    fontFamily: 'Roboto',
                  ),
                  MyText(
                    text: 'VETC',
                    size: 15,
                    color: kSecondaryColor,
                    fontFamily: 'Roboto',
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: kInputBorderColor,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kInputBorderColor.withOpacity(0.3),
                ),
              ),
            ),
            child: ListTile(
              onTap: () => Get.to(() => const History()),
              title: MyText(
                text: 'История',
                size: 15,
                color: kDarkGreyColor,
                fontFamily: 'Roboto',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: kInputBorderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
