import 'package:get/get.dart';
import 'package:pet_geo/model/map_model/list_page_model/list_page_model_all.dart';

class PetsController extends GetxController {
  bool? search = false;
  void showSearch() {
    search = !search!;
    update();
  }
  List<PetsModel> pets = [
    PetsModel(
      title: 'Кошка',
      subtitle: 'Кому бенгалов?',
      petImage: 'assets/images/download 1.png',
    ),
    PetsModel(
      title: 'Собака Грейс',
      subtitle: 'Грей — пес для опытных собачников',
      petImage: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
    ),
  ];

  List<PetsModel> get getPets => pets;
}
