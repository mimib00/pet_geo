import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/community_controller/community_contoller.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/community_model.dart';
import 'package:pet_geo/view/animal_communities/add_animal_community.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/events_feed/list_view_type.dart';
import 'package:pet_geo/view/pet_news_community_profile/pet_new_community_profile.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/search_box.dart';

class AnimalCommunities extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  AnimalCommunities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
      init: CommunityController(),
      builder: (logic) {
        logic.getCommunities();
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: true,
            haveTitle: false,
            addCustomTitle: true,
            customTitle: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: MyText(
                    paddingRight: 35.0,
                    text: 'Сообщества',
                    size: 18,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    align: TextAlign.right,
                    maxlines: 1,
                    overFlow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      //add new Animal Community
                      GestureDetector(
                        onTap: () => Get.to(() => const AddAnimalCommunity()),
                        child: Image.asset(
                          'assets/images/Icon Add.png',
                          height: 35,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            onTitleTap: () {},
            showSearch: () => logic.showSearch(),
            globalKey: _key,
          ),
          body: Column(
            children: [
              Visibility(
                visible: logic.search == true,
                child: SearchBox(
                  hintText: 'Поиск по сообществам',
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () => Get.to(() => const PetGeoScreen()),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: Image.asset('assets/images/Depositphotos_14094278_ds (1) 1.png'),
                      ),
                      title: MyText(
                        text: 'PetGeo',
                        size: 15,
                        fontFamily: 'Roboto',
                        color: kDarkGreyColor,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: kInputBorderColor,
                      ),
                    ),
                    FutureBuilder<List<Community>>(
                      future: logic.getCommunities(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          children: snapshot.data!
                              .map(
                                (e) => CommunityTiles(
                                  community: e,
                                  onTap: () => Get.to(() => PetNewsCommunityProfile(community: e)),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PetGeoScreen extends StatelessWidget {
  const PetGeoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        haveSearch: true,
        haveTitle: false,
        addCustomTitle: true,
        customTitle: Row(
          children: [
            Expanded(
              flex: 8,
              child: MyText(
                paddingRight: 35.0,
                text: 'Сообщества',
                size: 18,
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                align: TextAlign.right,
                maxlines: 1,
                overFlow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  //add new Animal Community
                  GestureDetector(
                    onTap: () => Get.to(() => const AddAnimalCommunity()),
                    child: Image.asset(
                      'assets/images/Icon Add.png',
                      height: 35,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        onTitleTap: () {},
        // globalKey: _key,
      ),
      body: GetBuilder<MapController>(
        init: MapController(),
        builder: (controller) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: controller.getAdList(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              snapshot.data!.removeWhere((element) => element['ad_type'] != "lost_pet_title" && element['ad_type'] != "found_pet_title");

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var ad = Ad.fromMap(snapshot.data![index]);
                  return Post(post: ad);
                },
              );
            },
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CommunityTiles extends StatelessWidget {
  final Community community;
  final Function()? onTap;
  const CommunityTiles({
    Key? key,
    required this.community,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kInputBorderColor.withOpacity(0.3),
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(180),
          child: CachedNetworkImage(
            imageUrl: community.photo,
            height: 50,
            width: 50,
          ),
        ),
        title: MyText(
          text: community.name,
          size: 15,
          fontFamily: 'Roboto',
          color: kDarkGreyColor,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: kInputBorderColor,
        ),
      ),
    );
  }
}
