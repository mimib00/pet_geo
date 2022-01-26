import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/custom_app_bar_1.dart';
import 'package:pet_geo/view/widget/help_methods/by_bounses.dart';
import 'package:pet_geo/view/widget/help_methods/by_money.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OfferHelp extends StatelessWidget {
  const OfferHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(
        haveTitle: true,
        title: 'Помощь',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: ToggleSwitch(
                minWidth: Get.width * 0.43,
                minHeight: 40.0,
                initialLabelIndex: 0,
                cornerRadius: 4.0,
                activeFgColor: kPrimaryColor,
                inactiveBgColor: kPrimaryColor,
                inactiveFgColor: kDarkGreyColor,
                totalSwitches: 2,
                borderWidth: 2.0,
                fontSize: 14,
                borderColor: const [
                  kInputBorderColor,
                  kInputBorderColor,
                ],
                activeBgColors: const [
                  [kSecondaryColor, kSecondaryColor],
                  [kSecondaryColor, kSecondaryColor],
                ],
                labels: const ['Бонусами', 'Перевести деньги'],
                onToggle: (index) {
                  index == 0
                      ? Get.to(() => const ByBonuses())
                      : Get.to(() => const ByMoney());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
