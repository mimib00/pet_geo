import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/events_feed_model/events_feed_model.dart';
import 'package:pet_geo/model/events_feed_model/save_post_model.dart';
import 'package:pet_geo/model/events_feed_model/stories_model.dart';
import 'package:pet_geo/model/post_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/stories/create_story.dart';
import 'package:pet_geo/view/stories/stories.dart';

class EventsFeedController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _adRef = FirebaseFirestore.instance.collection("ads");
  final CollectionReference<Map<String, dynamic>> _postRef = FirebaseFirestore.instance.collection("posts");

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
    var ads = mapController.ads;

    var res = _adRef.where("id", whereIn: ads.toList()).snapshots();
    final combined = [
      res
    ];
    return combined;
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

  // old code
  bool? isGridPostLike = false;
  bool? listView = true;
  bool? newSelectionKitSaved = false;
  bool? simplePostSave = false;
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

  List<StoriesModel> stories = [
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

  List<StoriesModel> get getStories => stories;

  List<EventsFeedGridViewModel> get getGridView => gridView;

  Future hidePopup() async {
    hidePopupAfterSavingKit = true;
    simplePostSave = false;
    update();
  }

  void simplySavePost() {
    simplePostSave = !simplePostSave!;
    update();
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
