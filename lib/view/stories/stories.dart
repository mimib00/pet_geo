import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Stories extends StatefulWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  bool? showPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: StepProgressIndicator(
                totalSteps: 100,
                currentStep: 50,
                size: 6,
                padding: 0,
                selectedColor: kPrimaryColor,
                unselectedColor: kPrimaryColor.withOpacity(0.6),
                roundedEdges: const Radius.circular(50),
              ),
            ),
            showPopup == true
                ? Center(
                    child: Container(
                      width: Get.width * 0.52,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      height: 61,
                      color: kPrimaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              showPopup = false;
                            }),
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: kDarkGreyColor,
                            ),
                          ),
                          Center(
                            child: MyText(
                              text: 'Сообщение отправлено',
                              size: 12,
                              weight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              color: kDarkGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                color: kPrimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: TextField(
                        cursorColor: const Color(0xffBEBEBE),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Color(0xffBEBEBE),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Сообщение',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Color(0xffBEBEBE),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: kSecondaryColor,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: kSecondaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () => setState(() {
                          showPopup = true;
                        }),
                        child: Image.asset(
                          'assets/images/share.png',
                          height: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
