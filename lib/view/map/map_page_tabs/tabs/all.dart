import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/view/bottom_sheets/ad_infro.dart';

class All extends StatelessWidget {
  const All({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (logic) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  initialCameraPosition: logic.initialPosition,
                  markers: logic.markers,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    if (!logic.ctrl.isCompleted) {
                      logic.ctrl.complete(controller);
                    }
                  },
                ),
              ),
            ),
            Visibility(
              visible: logic.showDetails.value,
              child: Positioned(
                bottom: 0,
                child: AdDetails(),
              ),
            )
          ],
        );
      },
    );
  }
}
