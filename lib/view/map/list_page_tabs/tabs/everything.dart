import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/controller/map_controller/list_page_controller/list_page_all_controller.dart';
import 'package:pet_geo/model/map_model/list_page_model/list_page_model_all.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import '../../specific_post.dart';

class Everything extends StatelessWidget {
  const Everything({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPageAllController>(
      init: ListPageAllController(),
      builder: (logic) {
        return ListView.separated(
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: kInputBorderColor.withOpacity(0.3),
          ),
          itemCount: logic.getListPageModelData.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var data = logic.getListPageModelData[index];
            return Tiles(data: data);
          },
        );
      },
    );
  }
}

class Tiles extends StatefulWidget {
  const Tiles({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PetsModel data;

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  final BottomNavBar _controller = Get.put(BottomNavBar());
  bool? bookMarked = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return ListTile(
          onTap: () {
            Get.to(() => _controller.screens[0]);
            logic.storiesHandler = false;
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              widget.data.petImage,
              height: 48,
              width: 48,
            ),
          ),
          title: MyText(
            text: widget.data.title,
            size: 16,
            weight: FontWeight.w600,
            color: kDarkGreyColor,
          ),
          subtitle: MyText(
            text: widget.data.subtitle,
            size: 14,
            color: kInputBorderColor,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => SpecificPost(
                          showBluePin: true,
                        ),
                      );
                    },
                    child: Container(
                      width: 25,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: kSecondaryColor,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Map Logo.png',
                          height: 13,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bookMarked = !bookMarked!;
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: kSecondaryColor,
                      ),
                      child: Center(
                        child: Image.asset(
                          bookMarked == true
                              ? 'assets/images/Vector (16).png'
                              : 'assets/images/bookmark.png',
                          height: 13,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
