import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_sheets/camera_options.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';

class Information extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        title: 'Информация',
        onTitleTap: () {},
        globalKey: _key,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Fields(
              hintText: 'название',
            ),
            Fields(
              hintText: 'Описание',
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topLeft,
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
                child: Image.asset(
                  'assets/images/Icon photo.png',
                  height: 77,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Fields extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var hintText;
  TextEditingController? textEditingController;

  Fields({Key? key,
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
          color: kDarkGreyColor,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: '$hintText'.toUpperCase(),
          hintStyle: const TextStyle(
            fontSize: 10,
            color: kDarkGreyColor,
            fontWeight: FontWeight.w600,
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
