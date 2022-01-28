import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
    update();
  }

  void goToUserLocation() {}

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
