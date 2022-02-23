// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:phonenumbers/phonenumbers.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Rx<User?> _currentUser = Rx<User?>(null);

  Rx<Users?> user = Users().obs;

  User? get currentUser => _currentUser.value;

  @override
  void onInit() {
    _currentUser.bindStream(_auth.authStateChanges());

    super.onInit();
  }

  void isNewUser(Map<String, dynamic> data) {
    try {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      TextEditingController name = TextEditingController();
      PhoneNumberEditingController phone = PhoneNumberEditingController();

      if (data["name"] == null) {
        Get.defaultDialog(
          barrierDismissible: false,
          title: "Enter your Information",
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Name",
                  label: "Name",
                  controller: name,
                  validate: (txt) {
                    if (txt == null || txt.isEmpty) return "You must enter a name";
                    return null;
                  },
                ),
                PhoneNumberField(
                  controller: phone,
                  countryCodeWidth: 50,
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          confirm: TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && phone.nationalNumber.isNotEmpty) {
                Map<String, dynamic> data = {
                  "name": name.text.trim(),
                  "phone": "+${phone.country!.prefix}${phone.nationalNumber}"
                };
                saveUserData(data);
              }
              Get.back();
            },
            child: const Text("Submit"),
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.black)),
          ),
        );
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

  void saveUserData(Map<String, dynamic> data) async {
    try {
      await _userRef.doc(_currentUser.value!.uid).update(data);
      getUserData(_currentUser.value!.uid);
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

  /// Fetches user's data from database.
  void getUserData(String uid) async {
    try {
      // fetch the data
      _firebaseMessaging.getToken().then((token) {
        _userRef.doc(_currentUser.value!.uid).set(
          {
            "token": token
          },
          SetOptions(merge: true),
        );
      });
      _userRef.doc(uid).get().then((snapshot) {
        if (!snapshot.exists) throw "User doesn't exist, Please register";
        isNewUser(snapshot.data()!);
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

  /// creates a user in Authentication and then add him to database.
  void createUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) throw "Couldn't create user";

      Map<String, dynamic> data = {
        "email": credential.user!.email
      };
      _userRef.doc(credential.user!.uid).set(data).then((value) {
        user.value = Users.fromMap(data, id: credential.user!.uid);
      });
      credential.user!.sendEmailVerification().then((value) => logout());

      Get.back();
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

  /// log a user in then get his data from database.
  void login(String email, String password) async {
    try {
      // login user
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (currentUser == null) return;

      if (!currentUser!.emailVerified) {
        logout();
        throw "check your email to verify it";
      }

      // fetch user data from firestore
      getUserData(currentUser!.uid);
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

  /// log a user out
  void logout() async {
    try {
      await _auth.signOut();
      Get.back();
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
}
