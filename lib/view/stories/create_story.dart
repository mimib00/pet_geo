import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/camera_controller.dart';
import 'package:pet_geo/view/constant/constant.dart';

class CreateStory extends StatefulWidget {
  const CreateStory({Key? key}) : super(key: key);

  @override
  State<CreateStory> createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory> {
  int selectedCamera = 0;
  late CameraController controller;

  final CamerasController cameraController = Get.put(CamerasController());

  initializeCamera(int cameraIndex) async {
    controller = CameraController(cameraController.cameras[cameraIndex], ResolutionPreset.max);
    await controller.initialize();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameraController.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Widget cameraWidget(context) {
    var camera = controller.value;
    // fetch screen size

    final size = Get.size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(
          controller,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                cameraController.takeImage(controller, scale);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(180),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: controller.value.isInitialized
          ? cameraWidget(context)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: ListTile(
          tileColor: kPrimaryColor,
          leading: GestureDetector(
            onTap: () {
              cameraController.openImage();
            },
            behavior: HitTestBehavior.opaque,
            child: const Icon(
              Icons.image_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              if (cameraController.cameras.length > 1) {
                setState(() {
                  selectedCamera = selectedCamera == 0 ? 1 : 0;
                  initializeCamera(selectedCamera);
                });
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Image.asset(
              'assets/images/cameraa.png',
              height: 25,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
