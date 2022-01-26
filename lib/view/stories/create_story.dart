import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

class CreateStory extends StatelessWidget {
  const CreateStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              'assets/images/Маска для аватарки. Возможно.png',
              height: 60,
              width: 60,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: ListTile(
          tileColor: kPrimaryColor,
          leading: Image.asset(
            'assets/images/Галлерея из телефона.png',
            height: 32,
            width: 32,
            fit: BoxFit.cover,
          ),
          trailing: Image.asset(
            'assets/images/cameraa.png',
            height: 25,
          ),
        ),
      ),
    );
  }
}
