import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/model/folder_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class FolderButton extends StatelessWidget {
  final Folder folder;
  final DocumentReference<Map<String, dynamic>>? post;

  FolderButton({
    Key? key,
    required this.folder,
    this.post,
  }) : super(key: key);
  final EventsFeedController controller = Get.put(EventsFeedController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.savePost(post!, folder.id),
      behavior: HitTestBehavior.opaque,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        color: kPrimaryColor,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          width: Get.width,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                height: 54,
                width: 54,
                child: Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kLightGreyColor,
                  ),
                  child: const Icon(
                    Icons.pets,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
            ),
            title: MyText(
              text: folder.name,
              size: 14,
              color: kBlackColor,
            ),
          ),
        ),
      ),
    );
  }
}

class AddFolder extends StatelessWidget {
  AddFolder({Key? key}) : super(key: key);
  final EventsFeedController controller = Get.find<EventsFeedController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        TextEditingController ctrl = TextEditingController();
        Get.defaultDialog(
          title: "Add Folder",
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Folder Name",
                  label: "",
                  controller: ctrl,
                  validate: (txt) {
                    if (txt == null || txt.isEmpty) return "You must enter a folder name";
                    return null;
                  },
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          confirm: TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.createFolder(ctrl.text.trim());
                Get.back();
              }
            },
            child: const Text("Save"),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        color: kPrimaryColor,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          width: Get.width,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            leading: Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kLightGreyColor,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.black,
                size: 35,
              ),
            ),
            title: MyText(
              text: "Add new folder",
              size: 14,
              color: kBlackColor,
            ),
          ),
        ),
      ),
    );
  }
}
