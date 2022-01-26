import 'package:get/get.dart';
import 'package:pet_geo/model/qr_model/pay_for_servicey_model.dart';
import 'package:pet_geo/view/qr/scan_qr_code.dart';


class QrController extends GetxController {
  List<PayForServiceyModel> payForServiceyModel = [
    PayForServiceyModel(
      petImg: 'assets/images/download 1.png',
      title: 'Отдам в добрые руки',
      subtitle: 'Кошка',
      onTap: () => Get.to(() => const ScanQrCode()),
    ),
    PayForServiceyModel(
      petImg: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
      title: 'Отдам на передержку',
      subtitle: 'Собака - Грейс',
      onTap: () => Get.to(() => const ScanQrCode()),
    ),
  ];

  List<PayForServiceyModel> get getPayForServiceyModel => payForServiceyModel;
}
