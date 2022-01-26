import 'package:get/get.dart';
import 'package:pet_geo/model/likes_model/likes_model.dart';

class LikesController extends GetxController {
  bool? search = false;

  void showSearch() {
    search = !search!;
    update();
  }
  List<LikesModel> likesModel = [
    LikesModel(
      name: 'Леонид Белов',
    ),
    LikesModel(
      name: 'Лиана Высоцкая',
    ),
    LikesModel(
      name: 'Ксения Урывина',
    ),
  ];

  List<LikesModel> get getLikesModel => likesModel;
}
