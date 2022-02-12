import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/model/map_model/list_page_model/list_page_model_all.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return GetBuilder<ListPageAllController>(
    //   init: ListPageAllController(),
    //   builder: (logic) {
    //     return ListView.separated(
    //       separatorBuilder: (context, index) => Container(
    //         height: 1,
    //         color: kInputBorderColor.withOpacity(0.3),
    //       ),
    //       itemCount: 2,
    //       shrinkWrap: true,
    //       physics: const BouncingScrollPhysics(),
    //       itemBuilder: (context, index) {
    //         var data = logic.getListPageModelData[index];
    //         return Tiles(data: data);
    //       },
    //     );
    //   },
    // );
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
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return ListTile(
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
                  Container(
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
                  Container(
                    width: 25,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: kSecondaryColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        widget.data.bookMarked == true ? 'assets/images/Vector (16).png' : 'assets/images/bookmark.png',
                        height: 13,
                        color: kPrimaryColor,
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
