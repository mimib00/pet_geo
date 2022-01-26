import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ShareModel {
  // ignore: prefer_typing_uninitialized_variables
  var shareAppIcon, appName;

  ShareModel({
    this.shareAppIcon,
    this.appName,
  });
}

class Share extends StatelessWidget {
  const Share({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return SizedBox(
          height: 190,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: MyText(
                  paddingTop: 15,
                  text: 'Поделиться',
                  size: 14,
                  weight: FontWeight.w700,
                  color: kBlackColor,
                ),
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemBuilder: (context, index) {
                    var data = logic.getShareModel[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              '${data.shareAppIcon}',
                              height: 41,
                              width: 41,
                            ),
                          ),
                          MyText(
                            paddingTop: 10.0,
                            text: '${data.appName}',
                            size: 14,
                            color: kBlackColor,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: logic.getShareModel.length,
                ),
              ),
              Container(),
            ],
          ),
        );
      },
    );
  }
}
