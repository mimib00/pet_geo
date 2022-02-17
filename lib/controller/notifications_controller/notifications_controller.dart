import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/notifications_model/notifications_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/friend_requests/friend_requests.dart';
import 'package:http/http.dart' as http;

class NotificationsController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _userRef = FirebaseFirestore.instance.collection("users");
  final AuthController authController = Get.find<AuthController>();
  RxList<NotificationsModel> notification = <NotificationsModel>[].obs;
  RxList<Users> requests = <Users>[].obs;
  @override
  void onInit() {
    getFriendRequests();
    super.onInit();
  }

  getFriendRequests() async {
    try {
      var user = authController.user.value!;

      var data = await _userRef.doc(user.id!).get();
      if (!data.exists) throw "User doesn't exist";
      if (data.data() == null) return;

      List invited = data.data()!["invited"];
      if (invited.isNotEmpty) {
        for (DocumentReference<Map<String, dynamic>> invite in invited) {
          var temp = await invite.get();
          requests.add(Users.fromMap(temp.data()!, id: temp.id));
        }
      }

      notification.add(
        NotificationsModel(
          title: "Friend Requests",
          msg: requests.length.toString(),
          onTap: () => Get.to(() => FriendRequests()),
        ),
      );

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

  acceptRequest(Users user) async {
    try {
      var me = authController.user.value!;
      var url = Uri.parse('https://europe-west2-petgeo-6f1ef.cloudfunctions.net/friend/accept');
      var res = await http.post(url, body: {
        "uid": me.id,
        "friend": user.id,
      });
      if (res.statusCode == 200) {
        requests.removeWhere((element) => element == user);
      }
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

  declineRequest(Users user) async {
    try {
      var me = authController.user.value!;
      var url = Uri.parse('https://europe-west2-petgeo-6f1ef.cloudfunctions.net/friend/cancel');
      var res = await http.post(url, body: {
        "uid": me.id,
        "friend": user.id,
      });
      if (res.statusCode == 200) {
        requests.removeWhere((element) => element == user);
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

  // old code
  // List<NotificationsModel> notificationModel = [
  //   NotificationsModel(
  //     haveFriendRequest: true,
  //   ),
  //   NotificationsModel(
  //     name: 'Леонид Белов',
  //     notificationMsg: 'ответил на комментарий',
  //     time: 'вчера в 19:23',
  //     haveNewNotification: true,
  //     onTap: () => Get.to(() => CommentOnPost(
  //           haveSlider: false,
  //         )),
  //   ),
  //   NotificationsModel(
  //     name: 'Лиана Высоцкая',
  //     notificationMsg: 'понравилась ваша',
  //     notificationThing: 'фотография',
  //     time: '8 июня в 13:01',
  //     onTap: () => Get.to(() => NewNotificationsPost()),
  //   ),
  // ];

  // List<NotificationsModel> get getNotificationModel => notificationModel;
}
