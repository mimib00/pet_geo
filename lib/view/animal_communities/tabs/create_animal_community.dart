import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_sheets/camera_options.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/pet_geo_executive_profile/pet_geo_executive_profile.dart';
import 'package:pet_geo/view/widget/my_button.dart';

class CreateAnimalCommunity extends StatelessWidget {
  const CreateAnimalCommunity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 8,
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
                    height: 15,
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
            Expanded(
              flex: 2,
              child: Center(
                child: SizedBox(
                  width: Get.width * 0.78,
                  child: MyButton(
                    text: 'Создать сообщество',
                    textSize: 16,
                    weight: FontWeight.w700,
                    btnBgColor: kSecondaryColor,
                    height: 47,
                    radius: 12.0,
                    onPressed: () => Get.to(() => const PetGeoExecutiveProfile()),
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

  Fields({
    Key? key,
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
          color: kDarkGreyColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: '$hintText'.toUpperCase(),
          hintStyle: const TextStyle(
            fontSize: 12,
            color: kDarkGreyColor,
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
