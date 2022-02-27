import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
