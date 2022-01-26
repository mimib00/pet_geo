import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';

import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import 'make_new_selection_kit.dart';

class SaveIntoSelectionKit extends StatelessWidget {
  const SaveIntoSelectionKit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: '     ',
                      size: 14,
                    ),
                    MyText(
                      text: 'Сохранить в',
                      size: 14,
                      weight: FontWeight.w700,
                      color: kBlackColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.bottomSheet(
                          const MakeNewSelectionKit(),
                          backgroundColor: kPrimaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          enableDrag: true,
                        );
                      },
                      child: Image.asset(
                        'assets/images/Icon Add.png',
                        height: 40,
                        color: kBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemBuilder: (context, index) {
                    var data = logic.getSavePostModel[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              '${data.post}',
                              height: 100,
                              width: 100,
                            ),
                          ),
                          MyText(
                            paddingTop: 10.0,
                            text: '${data.title}',
                            size: 14,
                            color: kBlackColor,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: logic.getSavePostModel.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
