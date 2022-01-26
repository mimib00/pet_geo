import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';

import 'logo.dart';
import 'my_text.dart';

// ignore: must_be_immutable
class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(140);
  // ignore: prefer_typing_uninitialized_variables
  var title;
  bool? haveTitle;

  CustomAppBar1({Key? key,
    this.title,
    this.haveTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Image.asset(
            'assets/images/Logo PG.png',
            height: 35,
            color: kPrimaryColor,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          child: textLogo(24),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                  'assets/images/back_button.png',
                  height: 35,
                ),
              ),
              haveTitle == true
                  ? MyText(
                      paddingRight: 35.0,
                      text: '$title',
                      size: 18,
                      fontFamily: 'Roboto',
                      color: kPrimaryColor,
                    )
                  : const SizedBox(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
