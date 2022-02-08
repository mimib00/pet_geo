import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/pet_model.dart';

class PetController extends GetxController {
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

  XFile? _image;

  XFile? get image => _image;
  RxString status = "".obs;

  final CollectionReference<Map<String, dynamic>> _petRef = FirebaseFirestore.instance.collection("pets");
  final _storage = FirebaseStorage.instance.ref();

  void selectGender(int index) => selectedGender.value = gender[index];
  void selectType(int index) => selectedAnimal.value = petTypes[index];

  void getImage() async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void removeImage() {
    _image = null;
    update();
  }

  void addPet(Map<String, dynamic> pet) async {
    try {
      MapController mapController = Get.find<MapController>();
      AuthController authController = Get.find<AuthController>();
      // upload image
      status.value = "Uploading image";
      if (_image == null) throw "You must choose an image for the ad";
      var path = "user/${authController.user.value!.id!}/${DateTime.now().microsecondsSinceEpoch}";
      TaskSnapshot snapshot = await _storage.child(path).putFile(File(_image!.path));
      if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) throw "There was an error durring upload";
      if (snapshot.state == TaskState.success) {
        status.value = "Adding the pet";

        var imageUrl = await snapshot.ref.getDownloadURL();

        // add data to a map
        Map<String, dynamic> data = {
          "type": selectedAnimal.value,
          "gender": selectedGender.value,
          "location": {
            "lat": mapController.latLng.value.latitude,
            "long": mapController.latLng.value.longitude,
          },
          "photo": imageUrl,
          "owner_id": FirebaseFirestore.instance.collection("users").doc(authController.user.value!.id!),
          ...pet
        };

        // add pet  to firestore
        var doc = await _petRef.add(data);

        // add pet to user

        FirebaseFirestore.instance.collection("users").doc(authController.user.value!.id!).update({
          "pets": FieldValue.arrayUnion([
            _petRef.doc(doc.id)
          ])
        });
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

  Future<Pet> getPets() async {
    // get all pets

    // make model of each pet

    //
    return Pet();
  }
}
