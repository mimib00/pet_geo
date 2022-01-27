import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bonus_space/where_to_spend_vetc_company/where_to_spend_vetc_company.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class WhereToSpendVetc extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  WhereToSpendVetc({Key? key}) : super(key: key);

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
        title: 'Где потратить VETC',
        globalKey: _key,
      ),
      body: ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemBuilder: (context, index) => whereToSpendVetcTiles(index),
      ),
    );
  }

  Widget whereToSpendVetcTiles(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kInputBorderColor.withOpacity(0.3),
          ),
        ),
      ),
      child: ListTile(
        onTap: () => Get.to(() => WhereToSpendVetcCompany()),
        title: MyText(
          text: 'Партнер ${index + 1}',
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
    );
  }
}
