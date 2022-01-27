import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/view/bottom_sheets/camera_options.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/my_button.dart';

import 'create_shelter_more_details.dart';

class CreateShelter extends StatefulWidget {
  const CreateShelter({Key? key}) : super(key: key);

  @override
  State<CreateShelter> createState() => _CreateShelterState();
}

class _CreateShelterState extends State<CreateShelter> {
  bool? next = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              flex: 8,
              child: InitailDetails(),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: SizedBox(
                  width: Get.width * 0.78,
                  child: MyButton(
                    text: 'Далее',
                    textSize: 16,
                    weight: FontWeight.w700,
                    btnBgColor: kSecondaryColor,
                    height: 47,
                    radius: 12.0,
                    onPressed: () {
                      Get.to(() => const CreateShelterMoreDetails());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InitailDetails extends StatelessWidget {
  const InitailDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Fields(
          hintText: 'название',
        ),
        Fields(
          hintText: 'Описание',
        ),
        const SizedBox(
          height: 15,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => Get.bottomSheet(
              CameraOptions(),
              backgroundColor: kPrimaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              enableDrag: true,
            ),
            child: Image.asset(
              'assets/images/Icon photo.png',
              height: 77,
            ),
          ),
        ),
      ],
    );
  }
}
