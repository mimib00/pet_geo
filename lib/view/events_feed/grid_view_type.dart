import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';

class GridViewType extends StatelessWidget {
  const GridViewType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (logic) {
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: logic.getGridView.length,
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 180,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            var gridData = logic.getGridView[index];
            return GridViewPosts(
              petImage: gridData.petImage,
            );
          },
        );
      },
    );
  }
}

// ignore: must_be_immutable
class GridViewPosts extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var petImage;

  GridViewPosts({Key? key,
    this.petImage,
  }) : super(key: key);

  @override
  State<GridViewPosts> createState() => _GridViewPostsState();
}

class _GridViewPostsState extends State<GridViewPosts> {
  bool? isGridPostLike = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            '${widget.petImage}',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: GestureDetector(
                onTap: () => setState(() {
                  isGridPostLike = !isGridPostLike!;
                }),
                child: Image.asset(
                  isGridPostLike == true
                      ? 'assets/images/filled_heart.png'
                      : 'assets/images/border_heart.png',
                  height: 20,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
