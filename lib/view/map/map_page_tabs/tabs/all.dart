import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';

class All extends StatelessWidget {
  const All({Key? key}) : super(key: key);

  // final CameraPosition initialPosition = const CameraPosition(
  //   target: LatLng(55.7558, 37.6173),
  //   zoom: 14.4746,
  // );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (logic) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GoogleMap(
            initialCameraPosition: logic.initialPosition,
            onMapCreated: (controller) {
              logic.ctrl.complete(controller);
            },
          ),
        );
      },
    );
  }
}
