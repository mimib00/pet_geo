import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/camera_controller.dart';
import 'package:pet_geo/view/widget/my_button.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CamerasController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Image.file(
                  controller.image!,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: "Back",
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 10),
                    MyButton(
                      text: "Post",
                      onPressed: () {
                        Get.defaultDialog(
                          title: "",
                          content: Obx(() => Text(controller.status.value)),
                        );
                        controller.createStory();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
