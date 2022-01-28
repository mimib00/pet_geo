import 'package:get/get.dart';
import 'package:pet_geo/utils/languages/en.dart';
import 'package:pet_geo/utils/languages/ru.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        "ru": ru,
      };
}
