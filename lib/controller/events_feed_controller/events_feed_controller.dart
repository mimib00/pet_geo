import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/events_feed_model/events_feed_model.dart';
import 'package:pet_geo/model/events_feed_model/save_post_model.dart';
import 'package:pet_geo/model/events_feed_model/stories_model.dart';
import 'package:pet_geo/model/post_model.dart';
import 'package:pet_geo/model/story_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/stories/create_story.dart';
import 'package:pet_geo/view/stories/stories.dart';

class EventsFeedController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _adRef = FirebaseFirestore.instance.collection("ads");
  final CollectionReference<Map<String, dynamic>> _postRef = FirebaseFirestore.instance.collection("posts");
  final CollectionReference<Map<String, dynamic>> _storyRef = FirebaseFirestore.instance.collection("stories");
  final AuthController authController = Get.find<AuthController>();

  RxList posts = [].obs;

  ///make ad
  void makeAdsPosts(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    var ad = Ad.fromMap(data.data());
    posts.add(ad);
  }

  void makeUserPost(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    var post = PostModel.fromMap(data.data(), data.id);
    posts.add(post);
  }

  /// return a truple of streams for stream builder
  List<Stream<QuerySnapshot<Map<String, dynamic>>>> getPostsStream() {
    posts.clear();
    MapController mapController = Get.put<MapController>(MapController());
    AuthController authController = Get.put<AuthController>(AuthController());
    var ads = mapController.ads;
    var user = authController.user.value!;

    if (ads.isNotEmpty) {
      var adPost = _adRef.where("id", whereIn: ads.toList()).snapshots();
      if (user.friends.isEmpty) {
        final combined = [
          adPost,
        ];
        return combined;
      }
      var post = _postRef.where("owner", whereIn: user.friends).snapshots();
      final combined = [
        adPost,
        post
      ];
      return combined;
    }

    return [];
  }

  Future<Users?> getLikeOwner(DocumentReference<Map<String, dynamic>> ref) async {
    var data = await ref.get();
    if (data.data() != null) {
      var user = Users.fromMap(data.data()!, id: data.id);
      return user;
    } else {
      return null;
    }
  }

  List<Stream<QuerySnapshot<Map<String, dynamic>>>> getUserPosts(Users user) {
    posts.clear();
    var ads = _adRef.where("owner", isEqualTo: FirebaseFirestore.instance.collection("users").doc(user.id)).snapshots();
    var post = _postRef.where("owner", isEqualTo: FirebaseFirestore.instance.collection("users").doc(user.id)).snapshots();

    final combined = [
      ads,
      post
    ];

    return combined;
  }

  void savePost(DocumentReference<Map<String, dynamic>> post, String collectionId) async {
    try {
      var user = authController.user.value!;
      await FirebaseFirestore.instance.collection("users").doc(user.id).collection("saved").doc(collectionId).update(
        {
          "posts": FieldValue.arrayUnion(
            [
              post
            ],
          )
        },
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
      );
    }
  }

  void deleteSave(DocumentReference<Map<String, dynamic>> post) async {
    try {
      var user = authController.user.value!;
      var res = await FirebaseFirestore.instance.collection("users").doc(user.id).collection("saved").where('posts', arrayContains: post).get();
      if (res.docs.isEmpty) return;
      for (var doc in res.docs) {
        doc.reference.update(
          {
            "posts": FieldValue.arrayRemove(
              [
                post
              ],
            ),
          },
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
      );
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> getFolders() async {
    try {
      var user = authController.user.value!;
      var res = await FirebaseFirestore.instance.collection("users").doc(user.id).collection("saved").get();
      return res;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
      );
    }
    return null;
  }

  void createFolder(String name) async {
    try {
      var user = authController.user.value!;
      Map<String, dynamic> data = {
        "name": name,
        "posts": []
      };
      FirebaseFirestore.instance.collection("users").doc(user.id).collection("saved").add(data);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
      );
    }
  }

  Future<bool> postSaved(DocumentReference<Map<String, dynamic>> post) async {
    var user = authController.currentUser.value!;
    var res = await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("saved").where("posts", arrayContains: post).get();
    if (res.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Story>> getStories() async {
    var user = authController.user.value!;

    if (user.friends.isNotEmpty) {
      List<Story> temp = [];
      var story = await _storyRef.where("owner", whereIn: user.friends).get();
      for (var doc in story.docs) {
        temp.add(Story.fromMap(doc.data(), uid: doc.id));
      }
      return temp;
    } else {
      return [];
    }
  }

  // old code
  bool? isGridPostLike = false;
  bool? listView = true;
  bool? newSelectionKitSaved = false;
  RxBool simplePostSave = false.obs;
  bool? hidePopupAfterSavingKit = true;
  var saveButtonColor = kInputBorderColor;
  TextEditingController newSelectionKitName = TextEditingController();
  bool? storiesHandler = true;
  var pageController = PageController();
  RxInt currentIndex = 0.obs;

  void hideStories() {
    storiesHandler = false;
    update();
  }

  void showStories() {
    storiesHandler = true;
    update();
  }

  List<EventsFeedGridViewModel> gridView = [
    EventsFeedGridViewModel(
      petImage: 'assets/images/scale_1200 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/download 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/scale_1200 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/download 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/scale_1200 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/download 1.png',
    ),
    EventsFeedGridViewModel(
      petImage: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
    ),
  ];

  final List<StoriesModel> _stories = [
    StoriesModel(
      haveNewStory: false,
      storyContent: 'assets/images/scale_1200 1.png',
      onTap: () => Get.to(() => const CreateStory()),
    ),
    StoriesModel(
      haveNewStory: true,
      storyContent: 'assets/images/profile.png',
      onTap: () => Get.to(() => const Stories()),
    ),
    StoriesModel(
      haveNewStory: true,
      storyContent: 'assets/images/download 1.png',
    ),
    StoriesModel(
      haveNewStory: false,
      storyContent: 'assets/images/Untitled.png',
    ),
    StoriesModel(
      haveNewStory: false,
      storyContent: 'assets/images/scale_1200 1.png',
    ),
    StoriesModel(
      haveNewStory: true,
      storyContent: 'assets/images/profile.png',
    ),
    StoriesModel(
      haveNewStory: true,
      storyContent: 'assets/images/download 1.png',
    ),
  ];

  List<SavePostModel> savePostModel = [
    SavePostModel(
      post: 'assets/images/scale_1200 1.png',
      title: 'Кошки',
    ),
    SavePostModel(
      post: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
      title: 'Собаки',
    ),
    SavePostModel(
      post: 'assets/images/a86fed14-d7d7-4494-b968-72598f3bac98 1.png',
      title: 'Все',
    ),
    SavePostModel(
      post: 'assets/images/23977efe-8bfd-442e-b84c-b5bc46293991_org 1.png',
      title: 'Другие',
    ),
  ];

  List<ShareModel> shareModel = [
    ShareModel(
      shareAppIcon: 'assets/images/Group 123.png',
      appName: 'Сообщение',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Post.png',
      appName: 'Пост',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Group 124.png',
      appName: 'WatsApp',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Group 125.png',
      appName: 'VK',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Group 129.png',
      appName: 'Ссылка',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Group 126.png',
      appName: 'Instagram',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Group 127.png',
      appName: 'СМС',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Facebook.png',
      appName: 'Facebook',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/Telegram.png',
      appName: 'Telegram',
    ),
    ShareModel(
      shareAppIcon: 'assets/images/ETC.png',
      appName: 'Прочее',
    ),
  ];

  List<ShareModel> get getShareModel => shareModel;

  List<SavePostModel> get getSavePostModel => savePostModel;

  List<StoriesModel> get stories => _stories;

  List<EventsFeedGridViewModel> get getGridView => gridView;

  Future hidePopup() async {
    hidePopupAfterSavingKit = true;
    simplePostSave.value = false;
    update();
  }

  void simplySavePost() {
    simplePostSave.value = !simplePostSave.value;
  }

  void saveSelectionKit() {
    newSelectionKitSaved == true ? Get.back() : null;
    hidePopupAfterSavingKit = false;
    update();
  }

  void saveButtonColorChange(value) {
    if (value.isNotEmpty) {
      saveButtonColor = kSecondaryColor;
      newSelectionKitSaved = true;
    } else {
      saveButtonColor = kInputBorderColor;
      newSelectionKitSaved = false;
    }
    update();
  }

  void showListView() {
    listView = !listView!;
    update();
  }

  void gridPostLike() {
    isGridPostLike = !isGridPostLike!;
    update();
  }
}
