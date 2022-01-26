import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/qr_controller/qr_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/qr/scanned_result.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({Key? key}) : super(key: key);

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  bool? afterQrScan = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrController>(
      init: QrController(),
      builder: (logic) {
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: CustomAppBar2(
            haveSearch: false,
            haveTitle: true,
            onTitleTap: () {},
            showSearch: () {},
            title: 'Генерация QR-кода',
            globalKey: _key,
          ),
          body: afterQrScan == true
              ? Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/qr_after.png',
                        height: Get.height * 0.357,
                        width: Get.width,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => ScannedResult()),
                        child: Container(
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: kSecondaryColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: MyText(
                              text: 'Оплата произведена!'.toUpperCase(),
                              size: 18,
                              weight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () => setState(() {
                    afterQrScan = true;
                  }),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 30,
                    ),
                    child: Image.asset(
                      'assets/images/qr_before.png',
                      height: Get.height * 0.357,
                      width: Get.width,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
