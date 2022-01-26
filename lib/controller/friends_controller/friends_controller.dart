import 'package:get/get.dart';
import 'package:pet_geo/model/friends_model/friends_model.dart';

class FriendsController extends GetxController {
  bool? search = false;

  void showSearch() {
    search = !search!;
    update();
  }

  List<FriendsModel> friendsModel = [
    FriendsModel(
      name: 'Леонид Белов',
    ),
    FriendsModel(
      name: 'Лиана Высоцкая',
    ),
    FriendsModel(
      name: 'Ксения Урывина',
    ),
  ];

  List<FriendsModel> get getFriendsModel => friendsModel;
}
