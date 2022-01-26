import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

class OpenCamera extends StatelessWidget {
  const OpenCamera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15,top: 60),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                  'assets/images/Delite all.png',
                  height: 20,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: ListTile(
          tileColor: kPrimaryColor,
          title: Image.asset(
            'assets/images/Маска для аватарки. Возможно.png',
            height: 60,
            width: 60,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }
}
