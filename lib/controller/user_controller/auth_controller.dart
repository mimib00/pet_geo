// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:pet_geo/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:pet_geo/view/user/user.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Rx<User?> _currentUser = Rx<User?>(null);

  Rx<Users?> user = Users().obs;

  Rx<User?> get currentUser => _currentUser;

  @override
  void onInit() {
    _auth.authStateChanges().listen(
      (users) {
        _currentUser.value = users;
        if (users == null) {
          Connectivity().checkConnectivity().then((connectivityResult) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
              var firstTime = prefs.getBool("first_time");
              if (firstTime == null || firstTime == true) {
                Get.offAll(() => OnBoardingScreen());
              } else {
                Get.offAll(() => const Authentication());
              }
            } else {
              Get.defaultDialog(
                title: "No Internet connection",
                content: SizedBox(
                  height: Get.height * .1,
                  child: const Center(child: Text("Please connect then retry again")),
                ),
                barrierDismissible: false,
              );
            }
          });
        } else {
          Connectivity().checkConnectivity().then(
            (connectivityResult) async {
              if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                getUserData(users.uid);
                Get.offAll(() => BottomNavBar(currentIndex: 3));
              } else {
                Get.defaultDialog(
                  title: "No Internet connection",
                  content: SizedBox(
                    height: Get.height * .1,
                    child: const Center(child: Text("Please connect then retry again")),
                  ),
                  barrierDismissible: false,
                );
              }
            },
          );
        }
      },
    );
    // Connectivity().checkConnectivity().then((connectivityResult) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    //     var firstTime = prefs.getBool("first_time");

    //     if (firstTime == null || firstTime == true) {
    //       Get.offAll(() => OnBoardingScreen());
    //     } else {}
    //   } else {
    //     Get.defaultDialog(
    //       title: "No Internet connection",
    //       content: SizedBox(
    //         height: Get.height * .1,
    //         child: const Center(child: Text("Please connect then retry again")),
    //       ),
    //       barrierDismissible: false,
    //     );
    //   }
    // });

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
                Get.back();
              }
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
      var token = await _firebaseMessaging.getToken();
      _userRef.doc(_currentUser.value!.uid).set(
        {
          "token": token
        },
        SetOptions(merge: true),
      );
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
  Future<void> getUserData(String uid) async {
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
      var snapshot = await _userRef.doc(uid).get();
      if (!snapshot.exists) throw "User doesn't exist, Please register";
      isNewUser(snapshot.data()!);

      user.value = Users.fromMap(snapshot.data()!, id: uid);
      update();
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
      _userRef.doc(credential.user!.uid).collection("saved").add({
        "name": "Genral",
        "posts": []
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
      if (_currentUser.value == null) return;

      if (!_currentUser.value!.emailVerified) {
        logout();
        throw "check your email to verify it";
      }

      // fetch user data from firestore
      getUserData(_currentUser.value!.uid);
      update();
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
