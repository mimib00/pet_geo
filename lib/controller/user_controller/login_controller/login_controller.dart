import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference<Map<String, dynamic>> userRef = FirebaseFirestore.instance.collection("users");
  bool? isGuest = false;

  void guestUser() {
    isGuest = true;
    update();
  }
}
