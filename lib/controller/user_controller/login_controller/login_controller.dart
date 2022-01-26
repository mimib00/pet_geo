import 'package:get/get.dart';

class LoginController extends GetxController {
  bool? isGuest = false;

  void guestUser() {
    isGuest = true;
    update();
  }
}
