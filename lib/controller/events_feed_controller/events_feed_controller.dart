import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/map_controller/map_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/events_feed_model/events_feed_model.dart';
import 'package:pet_geo/model/events_feed_model/save_post_model.dart';
import 'package:pet_geo/model/events_feed_model/stories_model.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/stories/create_story.dart';
import 'package:pet_geo/view/stories/stories.dart';
import 'package:stream_transform/stream_transform.dart';

class EventsFeedController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _adRef = FirebaseFirestore.instance.collection("ads");

  RxList posts = [].obs;

  ///make ad
  void makeAdsPosts(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    var ad = Ad.fromMap(data.data());
    posts.add(ad);
  }

  /// return a truple of streams for stream builder
  Stream<List<QuerySnapshot<Map<String, dynamic>>>> getPostsStream() {
    MapController mapController = Get.put<MapController>(MapController());
    var ads = mapController.ads;

    var res = _adRef.where("id", whereIn: ads.toList()).snapshots();
    final combined = res.combineLatestAll([]);

    return combined;
  }

  // void getPosts() async {
  //   MapController mapController = Get.put<MapController>(MapController());
  //   // get near ads
  //   var ads = await mapController.getAdList();

  //   // print(ads);
  //   // posts.addAll(ads);
  //   // update();

  //   // get comunity posts

  //   // get followed users posts

  //   // make objects
  //   List<Ad> tempAds = [];
  //   for (var ad in ads) {
  //     tempAds.add();
  //   }

  //   // put it in posts list

  //   posts.addAll(tempAds);
  //   posts.sort((a, b) {
  //     var dateA = a["created_at"] as Timestamp;
  //     var dateB = b["created_at"] as Timestamp;
  //     return dateA.compareTo(dateB);
  //   });
  //   update();
  // }

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
