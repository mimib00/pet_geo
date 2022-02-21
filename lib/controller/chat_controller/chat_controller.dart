import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/chat_model/chat_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/utils/helpers.dart';

class ChatController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _chatRef = FirebaseFirestore.instance.collection("chats");
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");
  final AuthController authController = Get.find<AuthController>();

  /// create a chatromm between 2 users.
  void createChatRoom(Users user) async {
    try {
      var me = authController.user.value!;
      var id = getId(me.id!, user.id!);
      var chatroom = await _chatRef.doc(id).get();
      if (chatroom.exists) return;
      Map<String, dynamic> data = {
        "users": [
          _userRef.doc(user.id),
          _userRef.doc(me.id),
        ],
        "last_message": ""
      };
      await _chatRef.doc(id).set(data);
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

  /// send message.
  void sendMessage(Users user, String message) async {
    try {
      var me = authController.user.value!;
      var id = getId(me.id!, user.id!);
      Map<String, dynamic> data = {
        "msg": message,
        "sender": _userRef.doc(me.id),
        "time": FieldValue.serverTimestamp(),
      };
      await _chatRef.doc(id).collection("chat").add(data);
      await _chatRef.doc(id).update(
        {
          "last_message": message
        },
      );
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

  Stream<QuerySnapshot<Map<String, dynamic>>>? getMessages(Users user) {
    try {
      var me = authController.user.value!;
      var id = getId(me.id!, user.id!);
      return _chatRef.doc(id).collection("chat").orderBy("time", descending: true).snapshots();
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
    return null;
  }

  bool search = false;

  void showSearch() {
    search = !search;
    update();
  }

  List<ChatHeadModel> chatHeadModel = [
    ChatHeadModel(
      name: 'Леонид Белов',
      msg: 'Хорошо',
      time: '5 мин.',
    ),
    ChatHeadModel(
      name: 'Лиана Высоцкая',
      msg: 'Вы: Я тебя поняла',
      time: '1 ч.',
      haveNewMsg: true,
    ),
    ChatHeadModel(
      name: 'Ксения Урывина',
      msg: 'ОК',
      time: '1 ч.',
      msgCounter: true,
    ),
  ];

  List<ChatHeadModel> get getChatHeadModel => chatHeadModel;
}
