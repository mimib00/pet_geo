import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import '../../specific_post.dart';

class Everything extends StatefulWidget {
  const Everything({Key? key}) : super(key: key);

  @override
  State<Everything> createState() => _EverythingState();
}

class _EverythingState extends State<Everything> {
  final MapController controller = Get.find<MapController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.getAdList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.separated(
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: kInputBorderColor.withOpacity(0.3),
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var data = snapshot.data![index];
              var ad = Ad.fromMap(data);
              return Tiles(data: ad);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class Tiles extends StatefulWidget {
  const Tiles({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Ad data;

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  bool? bookMarked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: widget.data.photoUrl,
            height: 48,
            width: 48,
          )),
      title: MyText(
        text: widget.data.nickname,
        size: 16,
        weight: FontWeight.w600,
        color: kDarkGreyColor,
      ),
      subtitle: MyText(
        text: widget.data.comment,
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
                      bookMarked == true ? 'assets/images/Vector (16).png' : 'assets/images/bookmark.png',
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
  }
}
