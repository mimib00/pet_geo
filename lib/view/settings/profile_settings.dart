import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_sheets/camera_options.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_button.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        globalKey: _key,
        haveTitle: true,
        title: 'Иван Иванов',
        haveFilter: false,
        onTitleTap: () {},
        showSearch: () {},
        showFilter: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
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
                        'assets/images/pexels-rachel-claire-5490235 1.png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ProfileTextField(
                  hintText: 'IvanovIvan@pochta.com',
                ),
                ProfileTextField(
                  hintText: '8 (123) 456 - 67 - 89',
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: Get.width * 0.6,
                child: MyButton(
                  onPressed: () {},
                  text: 'Сохранить',
                  radius: 12.0,
                  height: 47,
                  textSize: 16,
                  weight: FontWeight.w700,
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
class ProfileTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var hintText;
  TextEditingController? textEditingController;

  ProfileTextField({Key? key,
    this.hintText,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: textEditingController,
        cursorColor: kDarkGreyColor,
        style: const TextStyle(
          fontSize: 15,
          color: kDarkGreyColor,
          fontFamily: 'Roboto',
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 20),
          hintText: '$hintText',
          hintStyle: const TextStyle(
            fontSize: 15,
            color: kDarkGreyColor,
            fontFamily: 'Roboto',
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kInputBorderColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kInputBorderColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/visibility.png',
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
