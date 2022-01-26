import 'package:get/get.dart';

class MapController extends GetxController {
  bool? search = false, filterResultMapPins = true;
  bool? bluePinPopup = false, greenPinPopUp = false, greyPinPopUp = false;

  void showSearch() {
    search = !search!;
    update();
  }

  void showFilterResults(bool? back) {
    filterResultMapPins = true;
    back == true ? Get.back() : null;
    update();
  }

  void hideFilterResults() {
    filterResultMapPins = false;
    update();
  }

  void bluePinShowPopup() {
    bluePinPopup = !bluePinPopup!;
    update();
  }

  void hideBluePinPopUp() {
    bluePinPopup = false;
    update();
  }

  void greenPinPopUpShow() {
    greenPinPopUp = !greenPinPopUp!;
    update();
  }

  void hideGreenPinPopUp() {
    greenPinPopUp = false;
    update();
  }

  void greyPinPopUpShow() {
    greyPinPopUp = !greyPinPopUp!;
    update();
  }

  void hideGreyPinPopUp() {
    greyPinPopUp = false;
    update();
  }
}
