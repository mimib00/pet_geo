import 'package:get/get.dart';
import 'package:pet_geo/model/favorite_model/favorite_model.dart';

class FavoriteController extends GetxController {
  List<FavoriteModel> favoriteModel = [
    //this is is just for UI
    FavoriteModel(
      thumbnail: 'assets/images/download 1.png',
      albumName: 'Кошки',
    ),
    //this is is just for UI
    FavoriteModel(
      thumbnail: 'assets/images/download 1.png',
      albumName: 'Кошки',
    ),
    FavoriteModel(
      thumbnail: 'assets/images/scale_1200 1.png',
      albumName: 'Помощь приюту',
    ),
    FavoriteModel(
      thumbnail: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
      albumName: 'Собаки',
    ),
    //this is is just for UI
    FavoriteModel(
      thumbnail: 'assets/images/download 1.png',
      albumName: 'Кошки',
    ),
    //this is is just for UI
  ];

  List<FavoriteModel> get getFavoriteModel => favoriteModel;
}
