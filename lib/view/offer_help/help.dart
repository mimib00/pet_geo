import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/custom_app_bar_1.dart';
import 'package:pet_geo/view/widget/help_methods/by_bounses.dart';
import 'package:pet_geo/view/widget/help_methods/by_money.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(
        haveTitle: true,
        title: 'Помощь',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    height: 34,
                    color: kSecondaryColor,
                    shape: const StadiumBorder(),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: MyText(
                            text: 'Помогу приюту/питомцу',
                            size: 15,
                            align: TextAlign.left,
                            weight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyText(
                    paddingTop: 30.0,
                    size: 14,
                    paddingBottom: 10.0,
                    weight: FontWeight.w600,
                    color: kDarkGreyColor,
                    text: 'Выбрать кому будете помогать',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2.0,
                        color: kInputBorderColor,
                      ),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/pexels-rachel-claire-5490235 1.png',
                          height: 38,
                          width: 38,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: MyText(
                        text: 'Иван Иванов',
                        size: 14,
                        weight: FontWeight.w600,
                        color: kDarkGreyColor,
                      ),
                    ),
                  ),
                  MyText(
                    paddingTop: 20.0,
                    paddingBottom: 10.0,
                    text: 'Способ',
                    size: 14,
                    weight: FontWeight.w600,
                    color: kDarkGreyColor,
                  ),
                  Center(
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
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.7,
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    height: 47,
                    color: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () => Get.to(() => const ByBonuses()),
                    child: MyText(
                      text: 'Помочь',
                      size: 16,
                      weight: FontWeight.w700,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
