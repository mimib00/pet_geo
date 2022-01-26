import 'package:flutter/material.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ScannedResult extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   ScannedResult({Key? key}) : super(key: key);

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
        title: 'Оплатить услугу',
        globalKey: _key,
      ),
      body: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemBuilder: (context, index) {
          return PayForServiceyTiles(
            petImg: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
            title: 'Отдам на передержку',
            subtitle: 'Собака - Грейс',
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class PayForServiceyTiles extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var petImg, title, subtitle;
  VoidCallback? onTap;
  PayForServiceyTiles({Key? key,
    this.petImg,
    this.title,
    this.subtitle,
  }) : super(key: key);

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
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            '$petImg',
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: MyText(
          text: '$title',
          size: 16,
          weight: FontWeight.w600,
          color: kSkyBlueColor,
        ),
        subtitle: MyText(
          text: '$subtitle',
          size: 14,
          color: kInputBorderColor,
        ),
        trailing: Image.asset(
          'assets/images/QR.png',
          height: 35,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
