import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/favorite_controller/favorite_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

import 'all_publications.dart';

class Favorites extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final List allAlbum = [
    'assets/images/download 1.png',
    'assets/images/a86fed14-d7d7-4494-b968-72598f3bac98 1.png',
    'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
    'assets/images/scale_1200 1.png',
  ];

   Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      init: FavoriteController(),
      builder: (logic) {
        return Scaffold(
          backgroundColor: kLightGreyColor,
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: false,
            haveTitle: false,
            onTitleTap: () {},
            showSearch: () {},
            globalKey: _key,
          ),
          body: GridView.builder(
            shrinkWrap: true,
            itemCount: logic.getFavoriteModel.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 180,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
            ),
            itemBuilder: (context, index) {
              var favoriteData = logic.getFavoriteModel[index];
              return index == 0
                  ? allPublications(index)
                  : index == logic.getFavoriteModel.length - 1
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Icon Add.png',
                                height: 75,
                              ),
                              Center(
                                child: MyText(
                                  text: 'Создать папку',
                                  size: 14,
                                  weight: FontWeight.w700,
                                  color: kPrimaryColor,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  '${favoriteData.thumbnail}',
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MyText(
                                paddingTop: 5.0,
                                text: '${favoriteData.albumName}',
                                size: 12,
                                weight: FontWeight.w700,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        );
            },
          ),
        );
      },
    );
  }

  GestureDetector allPublications(int index) {
    return GestureDetector(
      onTap: () => Get.to(() => AllPublications()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            '${allAlbum[0]}',
                            fit: BoxFit.cover,
                            width: 86,
                            height: 82,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            '${allAlbum[1]}',
                            fit: BoxFit.cover,
                            width: 86,
                            height: 82,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            '${allAlbum[2]}',
                            fit: BoxFit.cover,
                            width: 86,
                            height: 82,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            '${allAlbum[3]}',
                            fit: BoxFit.cover,
                            width: 86,
                            height: 82,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: MyText(
              paddingTop: 5.0,
              text: 'Все публикации',
              size: 12,
              weight: FontWeight.w700,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}
