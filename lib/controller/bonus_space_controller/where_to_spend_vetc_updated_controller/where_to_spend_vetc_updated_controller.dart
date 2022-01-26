import 'package:get/get.dart';
import 'package:pet_geo/model/bonus_space_model/where_to_spend_vetc_updated_model/where_to_spend_vetc_updated_model.dart';

class WhereToSpendVetcUpdatedController extends GetxController {
  List<WhereToSpendVetcUpdatedModel> data = [
    WhereToSpendVetcUpdatedModel(
      title: 'Партнер 1',
      subtitle: 'Зоомагазин',
      petImage: 'assets/images/download 2.png',
    ),
    WhereToSpendVetcUpdatedModel(
      title: 'Партнер 2',
      subtitle: 'Зоомагазин',
      petImage: 'assets/images/download 2.png',
    ),
  ];

  List<WhereToSpendVetcUpdatedModel> get getData => data;
}
