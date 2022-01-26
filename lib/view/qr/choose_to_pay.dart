import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/qr/open_camera.dart';
import 'package:pet_geo/view/qr/pay_for_servicey.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ChooseToPay extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   ChooseToPay({Key? key}) : super(key: key);

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
        title: 'QR-Код',
        globalKey: _key,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 2),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kInputBorderColor.withOpacity(0.3),
                ),
              ),
            ),
            child: ListTile(
              onTap: () => Get.to(() => PayForServicey()),
              title: MyText(
                text: 'Как получить',
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
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kInputBorderColor.withOpacity(0.3),
                ),
              ),
            ),
            child: ListTile(
              onTap: () => Get.to(() => const OpenCamera()),
              title: MyText(
                text: 'Принять оплату',
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
