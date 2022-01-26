import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/community_controller/community_contoller.dart';
import 'package:pet_geo/view/animal_communities/tabs/create_animal_community.dart';
import 'package:pet_geo/view/animal_communities/tabs/create_shelter.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';

class AddAnimalCommunity extends StatefulWidget {
  const AddAnimalCommunity({Key? key}) : super(key: key);

  @override
  State<AddAnimalCommunity> createState() => _AddAnimalCommunityState();
}

class _AddAnimalCommunityState extends State<AddAnimalCommunity> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  var currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: currentTab);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
  }

  final List tabLabels = [
    'Приют',
    'Сообщество',
  ];
  final List<Widget> tabItems = [
    const CreateShelter(),
    const CreateAnimalCommunity(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
      init: CommunityController(),
      builder: (logic) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: false,
            haveTitle: true,
            title: 'Создание',
            addCustomTitle: true,
            onTitleTap: () {},
            globalKey: _key,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 2,
                          color: kLightGreyColor,
                        ),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: kPrimaryColor,
                          labelStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          labelPadding: EdgeInsets.zero,
                          unselectedLabelColor: kDarkGreyColor,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: currentTab == 0 ? const Radius.circular(50) : Radius.zero,
                              bottomLeft: currentTab == 0 ? const Radius.circular(50) : Radius.zero,
                              topRight: currentTab == 1 ? const Radius.circular(50) : Radius.zero,
                              bottomRight: currentTab == 1 ? const Radius.circular(50) : Radius.zero,
                            ),
                            color: kSecondaryColor,
                          ),
                          tabs: tabLabels
                              .map(
                                (e) => Text(
                                  e,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: tabItems.map((e) => e).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
