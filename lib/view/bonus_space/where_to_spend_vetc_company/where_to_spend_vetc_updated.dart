import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/bonus_space_controller/where_to_spend_vetc_updated_controller/where_to_spend_vetc_updated_controller.dart';
import 'package:pet_geo/model/bonus_space_model/where_to_spend_vetc_updated_model/where_to_spend_vetc_updated_model.dart';

import 'package:pet_geo/view/bonus_space/where_to_spend_vetc_company/bounus_space_specific_post.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';

import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class WhereToSpendVetcUpdated extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  WhereToSpendVetcUpdated({Key? key}) : super(key: key);

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
      body: GetBuilder<WhereToSpendVetcUpdatedController>(
          init: WhereToSpendVetcUpdatedController(),
          builder: (logic) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: kInputBorderColor.withOpacity(0.3),
              ),
              itemCount: logic.getData.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var data = logic.getData[index];
                return Tiles(data: data);
              },
            );
          }),
    );
  }
}

class Tiles extends StatefulWidget {
  const Tiles({
    Key? key,
    required this.data,
  }) : super(key: key);

  final WhereToSpendVetcUpdatedModel data;

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          widget.data.petImage,
          height: 48,
          width: 48,
        ),
      ),
      title: MyText(
        text: widget.data.title,
        size: 16,
        weight: FontWeight.w600,
        color: kDarkGreyColor,
      ),
      subtitle: MyText(
        text: widget.data.subtitle,
        size: 14,
        color: kInputBorderColor,
      ),
      trailing: GestureDetector(
        onTap: () {
          Get.to(
            () => BonusSpaceSpecificPost(
              showGreyPin: true,
            ),
          );
        },
        child: Container(
          width: 25,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: kSecondaryColor,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/Map Logo.png',
              height: 13,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
