import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_geo/view/stories/photo_view.dart';

import 'user_controller/auth_controller.dart';

class CamerasController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final CollectionReference<Map<String, dynamic>> _storyRef = FirebaseFirestore.instance.collection("stories");
  final _storage = FirebaseStorage.instance.ref();

  List<CameraDescription> _cameras = [];
  List<CameraDescription> get cameras => _cameras;

  File? _image;
  File? get image => _image;

  RxString status = "".obs;

  setAvaliableCameras(List<CameraDescription> cams) => _cameras = cams;

  void takeImage(CameraController controller, double scale) async {
    final temp = await controller.takePicture();

    _image = File(temp.path);
    Get.to(() => const PhotoView());
  }

  void openImage() async {
    final ImagePicker _picker = ImagePicker();
    final temp = await _picker.pickImage(source: ImageSource.gallery);
    _image = File(temp!.path);
    Get.to(() => const PhotoView());
  }

  createStory() async {
    try {
      var user = authController.user.value!;
      status.value = "Uploading image";

      if (_image == null) throw "You must choose an image for the ad";
      var path = "user/${authController.user.value!.id!}/${DateTime.now().microsecondsSinceEpoch}";
      TaskSnapshot snapshot = await _storage.child(path).putFile(File(_image!.path));
      if (snapshot.state == TaskState.error || snapshot.state == TaskState.canceled) throw "There was an error durring upload";
      if (snapshot.state == TaskState.success) {
        status.value = "Posting the Story";

        var imageUrl = await snapshot.ref.getDownloadURL();
        Map<String, dynamic> data = {
          "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
          "photo": imageUrl,
          "created_at": FieldValue.serverTimestamp(),
        };
        await _storyRef.add(data);
        Get.back();
        status.value = "";
      }
    } catch (e) {
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
}
