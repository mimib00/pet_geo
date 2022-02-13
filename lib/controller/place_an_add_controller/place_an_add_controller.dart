// ignore_for_file: unused_field, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/place_an_add/adopt_a_pet.dart';
import 'package:pet_geo/view/place_an_add/found_a_pet.dart';
import 'package:pet_geo/view/place_an_add/look_for_a_family_for_my_pet.dart';
import 'package:pet_geo/view/place_an_add/look_for_kennels.dart';
import 'package:pet_geo/view/place_an_add/lost_a_pet.dart';
import 'package:pet_geo/view/place_an_add/need_walking_a_dog.dart';
import 'package:pet_geo/view/place_an_add/offer_kennels.dart';
import 'package:pet_geo/view/place_an_add/offer_walking_a_dog.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PlaceAnAdController extends GetxController {
  List<String> gender = [
    'male_title',
    'female_title',
  ];
  List<String> petTypes = [
    'cat_title',
    'dog_title',
    'rabbit_title',
    'bird_title',
    'horse_title',
    'other_title',
  ];
  List<String> ages = [
    'adult_title',
    'little_title',
  ];

  RxString selectedGender = 'gender_title'.obs;
  RxString selectedAnimal = 'type_title'.obs;
  RxString adType = ''.obs;
  RxString age = 'age_title'.obs;

  XFile? _image;

  XFile? get image => _image;
  RxString status = "".obs;
  final CollectionReference<Map<String, dynamic>> _adRef = FirebaseFirestore.instance.collection("ads");
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");
  final _storage = FirebaseStorage.instance.ref();
  var currentIndex;
  RxList addCategory = [
    'found_pet_title'.tr,
    'lost_pet_title'.tr,
    'family_pet_title'.tr,
    'kennels_title'.tr,
    'kennels_offer_title'.tr,
    'adopt_title'.tr,
    'pet_walk_title'.tr,
    'pet_walk_offer_title'.tr,
  ].obs;
  RxList categoryColor = [
    kGreenColor,
    kRedColor,
    kSkyBlueColor,
    kSkyBlueColor,
    kPurpleColor,
    kSecondaryColor,
    kYellowColor,
    kBrownColor,
  ].obs;

  void currentCategory(var index) {
    var currentIndex = index;
    switch (currentIndex) {
      case 0:
        {
          adType.value = "found_pet_title";
          Get.to(() => FoundAPet());
        }
        break;

      case 1:
        {
          adType.value = "lost_pet_title";
          Get.to(() => const LostAPet());
        }
        break;
      case 2:
        {
          adType.value = "family_pet_title";
          Get.to(() => const LookForAFamilyForMyPet());
        }
        break;
      case 3:
        {
          adType.value = "kennels_title";
          Get.to(() => const LookForKennels());
        }
        break;
      case 4:
        {
          adType.value = "kennels_offer_title";
          Get.to(() => const OfferKennels());
        }
        break;
      case 5:
        {
          adType.value = "adopt_title";
          Get.to(() => const AdoptAPet());
        }
        break;
      case 6:
        {
          adType.value = "pet_walk_title";
          Get.to(() => const NeedWalkingADog());
        }
        break;
      case 7:
        {
          adType.value = "pet_walk_offer_title";
          Get.to(() => const OfferWalkingADog());
        }
        break;
      default:
        {}
        break;
    }
    update();
  }

  void placeAd(Map<String, dynamic> ad) async {
    try {
      MapController mapController = Get.find<MapController>();
      AuthController authController = Get.find<AuthController>();

      // upload image
      status.value = "Uploading image";

      if (_image == null) throw "You must choose an image for the ad";
      var path = "ads/${authController.user.value!.id!}/${DateTime.now().microsecondsSinceEpoch}";
      TaskSnapshot snapshot = await _storage.child(path).putFile(File(_image!.path));
      if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) throw "There was an error durring upload";
      if (snapshot.state == TaskState.success) {
        status.value = "Posting the ad";

        var imageUrl = await snapshot.ref.getDownloadURL();

        // add data to a map
        Map<String, dynamic> data = {
          "ad_type": adType.value,
          "gender": selectedGender.value,
          "age": age.value,
          "animal_type": selectedAnimal.value,
          "location": {
            "lat": mapController.latLng.value.latitude,
            "long": mapController.latLng.value.longitude,
          },
          "photo_url": imageUrl,
          "owner_id": authController.user.value!.id!,
          "created_at": FieldValue.serverTimestamp(),
          "likes": [],
          "comments": [],
          ...ad
        };

        //place an ad to firestore
        var doc = await _adRef.add(data);
        await doc.update({
          "id": doc.id
        });
        status.value = "Finishing up";

        // user firestore key to save geofire.
        Geofire.setLocation(doc.id, data["location"]["lat"], data["location"]["long"]);
        Get.back();
        status.value = "";
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
      );
    }
  }

  void selectGender(int index) => selectedGender.value = gender[index];
  void selectType(int index) => selectedAnimal.value = petTypes[index];
  void selectAge(int index) => age.value = ages[index];

  void getImage(bool fromCamera) async {
    final ImagePicker _picker = ImagePicker();
    if (fromCamera) {
      _image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      _image = await _picker.pickImage(source: ImageSource.gallery);
    }
    update();
  }

  void uploadProfilePic() async {
    try {
      AuthController authController = Get.find<AuthController>();

      status.value = "Uploading image";

      if (_image == null) throw "You must choose an image for the profile";
      var path = "user/${authController.user.value!.id!}/${DateTime.now().microsecondsSinceEpoch}";
      TaskSnapshot snapshot = await _storage.child(path).putFile(File(_image!.path));
      if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) throw "There was an error durring upload";
      if (snapshot.state == TaskState.success) {
        status.value = "Finishing up";

        var imageUrl = await snapshot.ref.getDownloadURL();
        Map<String, dynamic> data = {
          "photo": imageUrl,
        };

        await _userRef.doc(authController.user.value!.id!).update(data);
        authController.getUserData(authController.user.value!.id!);
        Get.back();
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
      );
    }
  }

  void restImage() {
    _image = null;
    update();
  }
}
