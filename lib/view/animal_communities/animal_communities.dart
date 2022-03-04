import 'package:advanced_stream_builder/advanced_stream_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/community_controller/community_contoller.dart';
import 'package:pet_geo/model/community_model.dart';
import 'package:pet_geo/view/animal_communities/add_animal_community.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
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
                child: FutureBuilder<List<Community>>(
                  future: logic.getCommunities(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        top: logic.search == true ? 70 : 0,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CommunityTiles(
                          community: snapshot.data![index],
                          onTap: () => Get.to(() => PetNewsCommunityProfile(community: snapshot.data![index])),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
