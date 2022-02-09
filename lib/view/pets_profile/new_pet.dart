import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/pet_controller.dart';
import '../bottom_sheets/gender.dart';
import '../bottom_sheets/pet_type.dart';
import '../constant/constant.dart';
import '../drawer/my_drawer.dart';
import '../place_an_add/place_an_add_widget.dart';
import '../widget/logo.dart';
import '../widget/my_text.dart';

class NewPetScreen extends StatefulWidget {
  const NewPetScreen({Key? key}) : super(key: key);

  @override
  State<NewPetScreen> createState() => _NewPetScreenState();
}

class _NewPetScreenState extends State<NewPetScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController petWeight = TextEditingController();
  TextEditingController petNickName = TextEditingController();
  TextEditingController petColor = TextEditingController();
  TextEditingController petAge = TextEditingController();

  PetController controller = Get.put<PetController>(PetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 140,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: GestureDetector(
              onTap: () => _key.currentState!.openDrawer(),
              child: Image.asset(
                'assets/images/Logo PG.png',
                height: 35,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
            child: textLogo(24),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(0, 0),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(
                'assets/images/back_button.png',
                height: 35,
              ),
            ),
            title: MyText(
              paddingRight: 35.0,
              text: 'add_pet_title'.tr,
              size: 18,
              fontFamily: 'Roboto',
              color: kPrimaryColor,
              align: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image selector
                GetBuilder<PetController>(
                  builder: (petController) {
                    if (petController.image == null) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => petController.getImage(),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                bottom: 3,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/Pet.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 5,
                              left: 50,
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                color: kInputBorderColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(180),
                            child: Image.file(
                              File(petController.image!.path),
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => petController.removeImage(),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(180),
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),

                const SizedBox(height: 15),
                // pet info

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: kInputBorderColor,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.bottomSheet(
                            PetType(),
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            enableDrag: true,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () {
                                  return MyText(
                                    text: controller.selectedAnimal.value.tr.toUpperCase(),
                                    size: 12,
                                    weight: FontWeight.w600,
                                    color: kDarkGreyColor,
                                  );
                                },
                              ),
                              Image.asset(
                                'assets/images/Polygon 2.png',
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: kInputBorderColor,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.bottomSheet(
                            Gender(),
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            enableDrag: true,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () {
                                  return MyText(
                                    text: controller.selectedGender.value.tr.toUpperCase(),
                                    size: 12,
                                    weight: FontWeight.w600,
                                    color: kDarkGreyColor,
                                  );
                                },
                              ),
                              Image.asset(
                                'assets/images/Polygon 2.png',
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: PlaceAnAddTextFields(
                        controller: petWeight,
                        hintText: 'weight_title'.tr,
                        keyboardType: TextInputType.number,
                        validate: (txt) {
                          if (txt == null || txt.isEmpty) return "* requierd";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: PlaceAnAddTextFields(
                        controller: petNickName,
                        hintText: 'nickname_title'.tr,
                        validate: (txt) {
                          if (txt == null || txt.isEmpty) return "* requierd";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: PlaceAnAddTextFields(
                        controller: petAge,
                        hintText: 'year_title'.tr,
                        keyboardType: TextInputType.number,
                        validate: (txt) {
                          if (txt == null || txt.isEmpty) return "* requierd";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: PlaceAnAddTextFields(
                        controller: petColor,
                        hintText: 'color_title'.tr,
                        validate: (txt) {
                          if (txt == null || txt.isEmpty) return "* requierd";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                // save button

                MaterialButton(
                  elevation: 0,
                  highlightElevation: 0,
                  height: 47,
                  color: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "name": petNickName.text.trim(),
                        "weight": int.parse(petWeight.text.trim()),
                        "year": petAge.text.trim(),
                        "color": petColor.text.trim(),
                      };

                      Get.defaultDialog(
                        title: "",
                        content: Obx(() => Text(controller.status.value)),
                      );

                      controller.addPet(data);
                    }
                  },
                  child: MyText(
                    text: 'add_pet_btn_title'.tr,
                    size: 16,
                    weight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
