import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/user_model.dart';

class FriendsController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  Future<List<Users>> getFriends() async {
    var user = authController.user.value!;
    List<Users> friends = [];
    for (DocumentReference<Map<String, dynamic>> friend in user.friends) {
      var temp = await friend.get();
      friends.add(Users.fromMap(temp.data()!, id: temp.id));
    }

    return friends;
  }
}
