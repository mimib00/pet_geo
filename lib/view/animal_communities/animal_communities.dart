import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/community_controller/community_contoller.dart';
import 'package:pet_geo/view/animal_communities/add_animal_community.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
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
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: logic.search == true ? 70 : 0,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: logic.getCommunityModel.length,
                  itemBuilder: (context, index) {
                    var data = logic.getCommunityModel[index];
                    return CommunityTiles(
                      communityLogo: data.communityLogo,
                      communityName: data.communityName,
                      onTap: data.onTap,
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
  CommunityTiles({
    Key? key,
    this.communityLogo,
    this.communityName,
    this.onTap,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var communityLogo, communityName;
  VoidCallback? onTap;

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
        leading: Image.asset(
          '$communityLogo',
          height: 40,
        ),
        title: MyText(
          text: '$communityName',
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
