import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/model/folder_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/favorites/all_publications.dart';
import 'package:pet_geo/view/widget/custom_text_field.dart';
import 'package:pet_geo/view/widget/logo.dart';

class Favorites extends StatelessWidget {
  Favorites({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: kLightGreyColor,
          key: _key,
          drawer: const MyDrawer(),
          appBar: AppBar(
            elevation: 0,
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
          ),
          body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>?>(
            future: controller.getFolders(),
            builder: (context, snapshot) {
              if (snapshot.hasError) throw snapshot.error.toString();
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 180,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.docs.length + 1,
                itemBuilder: (context, index) {
                  if (index == snapshot.data!.docs.length) {
                    return AddFolder();
                  } else {
                    var data = snapshot.data!.docs[index].data();

                    var folder = Folder(id: snapshot.data!.docs[index].id, name: data['name'], posts: data['posts'].cast<DocumentReference<Map<String, dynamic>>>());
                    return FolderTile(folder: folder);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

class FolderTile extends StatelessWidget {
  final Folder folder;
  const FolderTile({
    Key? key,
    required this.folder,
  }) : super(key: key);

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getLastPost() async {
    List<DocumentSnapshot<Map<String, dynamic>>> saved = [];
    if (folder.posts.isNotEmpty) {
      for (var doc in folder.posts) {
        saved.add(await doc.get());
      }

      return saved;
    }
    return saved;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
      future: getLastPost(),
      builder: (context, snapshot) {
        if (snapshot.hasError) throw snapshot.error.toString();

        if (snapshot.data == null || !snapshot.data!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kLightGreyColor,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Icon(
                    Icons.pets,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
              Text(folder.name)
            ],
          );
        }

        Widget child = snapshot.data!.length >= 4
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) => SizedBox(
                          width: Get.width / 2,
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data![index].data()!["photo_url"],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(folder.name),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: Get.width / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.first.data()!["photo_url"],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Text(folder.name)
                ],
              );
        return GestureDetector(
          onTap: () => Get.to(() => AllPublications(folder: folder)),
          behavior: HitTestBehavior.opaque,
          child: child,
        );
      },
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
      child: Container(
        width: Get.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kLightGreyColor,
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
              size: 50,
            ),
            Text("Create a folder")
          ],
        ),
      ),
    );
  }
}
