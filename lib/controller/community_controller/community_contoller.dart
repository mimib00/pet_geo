import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/community_model/community_model.dart';
import 'package:pet_geo/view/pet_geo_community_profile_for_mods/pet_geo_community_profile_for_mods.dart';
import 'package:pet_geo/view/pet_geo_guest_profile/pet_geo_guest_profile.dart';
import 'package:pet_geo/view/pet_news_community_profile/pet_new_community_profile.dart';

class CommunityController extends GetxController {
  RxString status = "".obs;

  XFile? _image;
  XFile? get image => _image;

  XFile? _logo;
  XFile? get logo => _logo;

  final AuthController authController = Get.find<AuthController>();

  final CollectionReference<Map<String, dynamic>> _communityRef = FirebaseFirestore.instance.collection("communities");
  final _storage = FirebaseStorage.instance.ref();

  void getImage(bool fromCamera, bool isLogo) async {
    final ImagePicker _picker = ImagePicker();

    if (fromCamera) {
      if (isLogo) {
        _logo = await _picker.pickImage(source: ImageSource.camera);
      } else {
        _image = await _picker.pickImage(source: ImageSource.camera);
      }
    } else {
      if (isLogo) {
        _logo = await _picker.pickImage(source: ImageSource.gallery);
      } else {
        _image = await _picker.pickImage(source: ImageSource.gallery);
      }
    }
    update();
  }

  void createComunity(Map<String, dynamic> community) async {
    try {
      // upload image
      status.value = "Uploading image";
      if (_image == null || _logo == null) throw "You must choose an image for the logo and cover";
      var logoPath = "communities/${authController.user.value!.id!}/${DateTime.now().microsecondsSinceEpoch}";
      var imagePath = "communities/${authController.user.value!.id!}/${DateTime.now().microsecondsSinceEpoch}";

      TaskSnapshot logoSnapshot = await _storage.child(logoPath).putFile(File(_logo!.path));
      TaskSnapshot imageSnapshot = await _storage.child(imagePath).putFile(File(_image!.path));

      if (logoSnapshot.state == TaskState.error || logoSnapshot.state == TaskState.canceled || imageSnapshot.state == TaskState.error || imageSnapshot.state == TaskState.canceled) throw "There was an error durring upload";
      if (logoSnapshot.state == TaskState.success && imageSnapshot.state == TaskState.success) {
        status.value = "creating the community";

        var logoUrl = await logoSnapshot.ref.getDownloadURL();
        var imageUrl = await imageSnapshot.ref.getDownloadURL();

        // add data to a map
        Map<String, dynamic> data = {
          "type": "Community",
          "followers": [],
          "mods": [],
          "blocked": [],
          "photo": logoUrl,
          "cover": imageUrl,
          "owner": FirebaseFirestore.instance.collection("users").doc(authController.user.value!.id!),
          ...community
        };

        //place an ad to firestore
        await _communityRef.add(data);
        status.value = "Finishing up";
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

  void getCommunities() {}

  void restImage(bool isLogo) {
    if (isLogo) {
      _logo = null;
    } else {
      _image = null;
    }

    update();
  }

  // old code
  bool? search = false;

  void showSearch() {
    search = !search!;
    update();
  }

  List<CommunityModel> communityModel = [
    CommunityModel(
      communityLogo: 'assets/images/Depositphotos_14094278_ds (1) 1.png',
      communityName: 'PetGeo',
      onTap: () => Get.to(() => const PetGeoGuestProfile()),
    ),
    CommunityModel(
      communityLogo: 'assets/images/Depositphotos_250473480_ds 1.png',
      communityName: 'PetNews',
      onTap: () => Get.to(() => const PetNewsCommunityProfile()),
    ),
    CommunityModel(
      communityLogo: 'assets/images/Events Logo.png',
      communityName: 'Example For Mod',
      onTap: () => Get.to(() => const PetGeoCommunityProfileForMods()),
    ),
  ];
  List<MessagesModel> msgs = [
    MessagesModel(
      name: 'Леонид Белов',
    ),
    MessagesModel(
      name: 'Лиана Высоцкая',
      add: true,
    ),
    MessagesModel(
      name: 'Ксения Урывина',
      add: true,
    ),
    MessagesModel(
      name: 'Лиана Высоцкая',
      add: true,
    ),
  ];

  List<MessagesModel> get getMessagesModel => msgs;

  List<CommunityModel> get getCommunityModel => communityModel;
}
