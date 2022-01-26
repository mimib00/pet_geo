import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class MakeNewSelectionKit extends StatelessWidget {
  const MakeNewSelectionKit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return SizedBox(
          height: 230,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                    ),
                    MyText(
                      text: 'Новая подборка',
                      size: 14,
                      weight: FontWeight.w700,
                      color: kBlackColor,
                    ),
                    GestureDetector(
                      onTap: () => logic.saveSelectionKit(),
                      child: MyText(
                        text: 'Сохранить',
                        size: 14,
                        weight: FontWeight.w700,
                        color: logic.saveButtonColor,
                      ),
                    ),
                  ],
                ),
                Container(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/a86fed14-d7d7-4494-b968-72598f3bac98 1.png',
                    height: 86,
                    width: 86,
                    fit: BoxFit.cover,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    logic.saveButtonColorChange(value);
                  },
                  cursorColor: kDarkGreyColor,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kDarkGreyColor,
                    fontFamily: 'Roboto',
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kInputBorderColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kInputBorderColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
