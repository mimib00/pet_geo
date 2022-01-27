// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/model/user_model.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");

  Rx<User?> _currentUser = Rx<User?>(null);

  Rx<Users?> user = Rx<Users?>(null);

  User? get currentUser => _currentUser.value;

  @override
  void onInit() {
    _currentUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  /// Check if user exists in database and return true, or false
  void userExist(String email) {
    _userRef.where("email", isEqualTo: email).get().then((data) {
      if (data.size > 0) {
        Get.snackbar(
          "Error",
          "Email already exists",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          colorText: Colors.white,
          backgroundColor: Colors.red[400],
        );
      }
    });
  }

  getUserData(String uid) async {
    try {
      // fetch the data
      _userRef.doc(uid).get().then((snapshot) {
        if (!snapshot.exists) throw "User doesn't exist, Please register";

        user.value = Users.fromMap(snapshot.data()!, id: uid);
        update();
      });
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

  createUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) throw "Couldn't create user";
      Map<String, dynamic> data = {
        "email": credential.user!.email
      };
      _userRef.doc(credential.user!.uid).set(data).then((value) {
        user.value = Users.fromMap(data, id: credential.user!.uid);
      });
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

  login(String email, String password) async {
    try {
      // login user
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (currentUser == null) return;

      // fetch user data from firestore
      getUserData(currentUser!.uid);
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

  logout() async {
    try {
      await _auth.signOut();
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
