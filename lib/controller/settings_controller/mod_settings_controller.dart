import 'package:get/get.dart';
import 'package:pet_geo/model/settings_model/settings_model.dart';

class ModSettingsController extends GetxController {
  bool? search = false;

  void showSearch() {
    search = !search!;
    update();
  }

  void hideSearch() {
    search = false;
    Get.back();
    update();
  }

  List<SettingsModel> settingsModel = [
    SettingsModel(
      title: 'Леонид Белов',
    ),
    SettingsModel(
      title: 'Лиана Высоцкая',
    ),
  ];

  List<SettingsModel> get getSettingsModel => settingsModel;
}
