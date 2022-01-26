import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_button.dart';

class ChangePassword extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   ChangePassword({Key? key}) : super(key: key);

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
        title: 'Сменить пароль',
        globalKey: _key,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Fields(
                    hintText: 'Старый пароль',
                  ),
                  Fields(
                    hintText: 'Новый пароль',
                  ),
                  Fields(
                    hintText: 'Повторите новый пароль',
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: SizedBox(
                  width: Get.width * 0.6,
                  child: MyButton(
                    onPressed: () {},
                    height: 47,
                    btnBgColor: kSecondaryColor,
                    text: 'Сохранить',
                    weight: FontWeight.w700,
                    textColor: kPrimaryColor,
                    textSize: 16,
                    radius: 12.0,
                  ),
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
          fontSize: 12,
          color: kInputBorderColor,
        ),
        decoration: InputDecoration(
          hintText: '$hintText',
          hintStyle: const TextStyle(
            fontSize: 12,
            color: kInputBorderColor,
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
