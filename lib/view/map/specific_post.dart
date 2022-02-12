import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/filter/filter.dart';
import 'package:pet_geo/view/widget/logo.dart';

// ignore: must_be_immutable
class SpecificPost extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final Map<String, dynamic> location;

  SpecificPost({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (logic) {
        return Scaffold(
          key: _key,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 142,
            leading: Center(
              child: GestureDetector(
                onTap: () => _key.currentState!.openDrawer(),
                child: Image.asset(
                  'assets/images/Logo PG.png',
                  height: 35,
                  color: kPrimaryColor,
                ),
              ),
            ),
            title: ColorFiltered(
              colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
              child: textLogo(24),
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () => Get.off(
                    () => BottomNavBar(
                      currentIndex: 3,
                    ),
                  ),
                  child: Image.asset(
                    logic.search == true ? 'assets/images/Vector (16).png' : 'assets/images/Serach.png',
                    height: logic.search == true ? 23 : 37,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: logic.search == true ? 20 : 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _key.currentState!.openEndDrawer(),
                    child: Image.asset(
                      'assets/images/Filter.png',
                      height: 37,
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size(0, 0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    'assets/images/back_button.png',
                    height: 35,
                  ),
                ),
                minLeadingWidth: 70.0,
              ),
            ),
          ),
          endDrawer: Filter(
            onTap: () => logic.showFilterResults(true),
          ),
          drawer: const MyDrawer(),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(location["lat"], location["long"]),
                  zoom: 14.4746,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("widget.pet!.id!"),
                    position: LatLng(location["lat"], location["long"]),
                    consumeTapEvents: true,
                  ),
                },
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                zoomGesturesEnabled: false,
                tiltGesturesEnabled: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
