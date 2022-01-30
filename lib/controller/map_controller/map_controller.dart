import 'dart:async';

import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';

class MapController extends GetxController {
  // New Code
  Location location = Location();
  Rx<LatLng> latLng = const LatLng(55.7558, 37.6173).obs;

  Completer<GoogleMapController> ctrl = Completer();

  CameraPosition get initialPosition => CameraPosition(
        target: latLng.value,
        zoom: 14.4746,
      );

  @override
  void onInit() async {
    getPermissions();
    super.onInit();
  }

  void getPermissions() async {
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    getUserLocation();
  }

  void getUserLocation() async {
    LocationData locationData = await location.getLocation();
    latLng.value = LatLng(locationData.latitude!, locationData.longitude!);
    final GoogleMapController controller = await ctrl.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng.value,
          zoom: 14.4746,
        ),
      ),
    );
    // addMyLocation(LatLng(locationData.latitude!, locationData.longitude!));
    update();
  }

  void addMyLocation(LatLng latLng) {
    AuthController authController = Get.find<AuthController>();
    var user = authController.currentUser!;

    Geofire.setLocation(user.uid, latLng.latitude, latLng.longitude);
  }

  // Old Code
  bool? search = false, filterResultMapPins = true;
  bool? bluePinPopup = false, greenPinPopUp = false, greyPinPopUp = false;

  void showSearch() {
    search = !search!;
    update();
  }

  void showFilterResults(bool? back) {
    filterResultMapPins = true;
    back == true ? Get.back() : null;
    update();
  }

  void hideFilterResults() {
    filterResultMapPins = false;
    update();
  }

  void bluePinShowPopup() {
    bluePinPopup = !bluePinPopup!;
    update();
  }

  void hideBluePinPopUp() {
    bluePinPopup = false;
    update();
  }

  void greenPinPopUpShow() {
    greenPinPopUp = !greenPinPopUp!;
    update();
  }

  void hideGreenPinPopUp() {
    greenPinPopUp = false;
    update();
  }

  void greyPinPopUpShow() {
    greyPinPopUp = !greyPinPopUp!;
    update();
  }

  void hideGreyPinPopUp() {
    greyPinPopUp = false;
    update();
  }
}
