// ignore_for_file: empty_catches

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pet_geo/model/ad_model.dart';

class MapController extends GetxController {
  RxBool showDetails = false.obs;
  Ad? ad;
  // New Code
  Location location = Location();
  Rx<LatLng> latLng = const LatLng(55.7558, 37.6173).obs;

  RxSet<Marker> markers = <Marker>{}.obs;

  final CollectionReference<Map<String, dynamic>> _adRef = FirebaseFirestore.instance.collection("ads");

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
    queryAllAds(latLng.value);
  }

  void queryAllAds(LatLng _latLng) {
    Geofire.queryAtLocation(_latLng.latitude, _latLng.longitude, 15)?.listen((map) {
      if (map != null) {
        var callBack = map['callBack'];
        if (callBack == Geofire.onGeoQueryReady) {
          for (var key in map['result']) {
            getAdDetails(key);
          }
        }
      }
    });
  }

  void getAdDetails(String key) async {
    try {
      var res = await _adRef.doc(key).get();
      var data = res.data();

      if (data == null) throw "No ad data found";

      // make the marker Set.
      markers.add(
        Marker(
          markerId: MarkerId(res.id),
          position: LatLng(data["location"]["lat"], data["location"]["long"]),
          onTap: () {
            ad = Ad.fromMap(data);
            togglePanel(true);
          },
          consumeTapEvents: true,
        ),
      );
      update();
    } catch (e) {}

    // print(res.data());
  }

  void togglePanel(bool status) {
    showDetails.value = status;
    update();
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
