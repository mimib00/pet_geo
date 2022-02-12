// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/comments/comments.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class ListViewType extends StatelessWidget {
  const ListViewType({Key? key}) : super(key: key);

  // EventsFeedController controller = Get.put<EventsFeedController>(EventsFeedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(builder: (controller) {
      return StreamBuilder<List<QuerySnapshot<Map<String, dynamic>>>>(
        stream: controller.getPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var ads = snapshot.data;

          for (var ad in ads![0].docs) {
            controller.makeAdsPosts(ad);
          }
          for (var ad in ads[1].docs) {
            controller.makeAdsPosts(ad);
          }
          return ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              print(ads[index]);
              var post = controller.posts[index];
              return Post(post: post);
            },
          );

          // return StreamBuilder<String>(
          //   stream: controller.streams[1],
          //   builder: (context, snapshot2) {
          //     print(snapshot2.data == null);
          //     if (snapshot2.data == null) return Container();
          //     if (snapshot2.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     var ads2 = snapshot2.data!;
          //     print("ADS2: $ads2");
          //     // for (var ad in ads) {
          //     //   controller.makeAdsPosts(ad);
          //     // }
          //     return ListView.builder(
          //       padding: const EdgeInsets.only(
          //         bottom: 30,
          //       ),
          //       physics: const BouncingScrollPhysics(),
          //       itemCount: controller.posts.length,
          //       itemBuilder: (context, index) {
          //         var post = controller.posts[index];
          //         return Post(post: post);
          //       },
          //     );
          //   },
          // );
        },
      );
    });
  }
}

class Post extends StatelessWidget {
  final dynamic post;
  const Post({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    switch (post.runtimeType.toString()) {
      case "Ad":
        child = AdPost(ad: post);
        break;
      default:
    }
    return child;
  }
}

class AdPost extends StatefulWidget {
  final Ad ad;
  const AdPost({
    Key? key,
    required this.ad,
  }) : super(key: key);

  @override
  State<AdPost> createState() => _AdPostState();
}

class _AdPostState extends State<AdPost> {
  Future<Users> getOwner() async {
    var temp = await widget.ad.owner!.get();
    return Users.fromMap(temp.data()!, id: temp.id);
  }

  late bool isLiked = false;
  @override
  void initState() {
    AuthController controller = Get.find<AuthController>();
    isLiked = widget.ad.likes.contains(controller.user.value!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users>(
        future: getOwner(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasError) throw snapshot.error.toString();
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var owner = snapshot.data!;
            var time = DateFormat("MMMM d, H:m").format(widget.ad.createdAt!.toDate());
            Widget type = const Text('');

            switch (widget.ad.adType) {
              case "found_pet_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kGreenColor,
                );

                break;
              case "lost_pet_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kRedColor,
                );
                break;
              case "family_pet_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kSkyBlueColor,
                );
                break;
              case "kennels_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kSkyBlueColor,
                );
                break;
              case "kennels_offer_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kPurpleColor,
                );
                break;
              case "adopt_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kSecondaryColor,
                );
                break;
              case "pet_walk_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kYellowColor,
                );
                break;
              case "pet_walk_offer_title":
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kBrownColor,
                );
                break;

              default:
                type = MyText(
                  text: widget.ad.adType.tr,
                  size: 18,
                  weight: FontWeight.w700,
                  paddingLeft: 15,
                  paddingTop: 15,
                  color: kGreenColor,
                );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kInputBorderColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: CachedNetworkImage(
                        imageUrl: owner.photoUrl,
                        width: 42,
                        height: 42,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/Group 30.png',
                          height: 20,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    title: MyText(
                      text: owner.name,
                      size: 12,
                      color: kDarkGreyColor,
                      weight: FontWeight.w700,
                      fontFamily: 'Roboto',
                    ),
                    subtitle: MyText(
                      text: time.toString(),
                      size: 12,
                      color: kInputBorderColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                type,
                MyText(
                  text: widget.ad.comment,
                  size: 14,
                  fontFamily: 'Roboto',
                  color: kDarkGreyColor,
                  paddingLeft: 15,
                  paddingTop: 15,
                ),
                SizedBox(
                  height: 353,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: widget.ad.photoUrl,
                            width: Get.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 22.0,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isLiked) {
                                widget.ad.unLike();
                                setState(() {
                                  isLiked = false;
                                });
                              } else {
                                widget.ad.like();
                                setState(() {
                                  isLiked = true;
                                });
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                              size: 25,
                              color: isLiked ? Colors.red : Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(
                              () => Comments(
                                comments: widget.ad.comments,
                                ad: widget.ad,
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/comment.png',
                              height: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.bottomSheet(
                              const Share(),
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
                              'assets/images/share.png',
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/Vector (16).png',
                          height: 20,
                          color: kDarkGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
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
          return Container();
        });
  }
}

// class PostWidget extends StatelessWidget {
//   final dynamic post;
//   const PostWidget({
//     Key? key,
//     this.post,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<EventsFeedController>(
//       init: EventsFeedController(),
//       builder: (logic) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 15),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: kInputBorderColor.withOpacity(0.3),
//                   ),
//                 ),
//               ),
//               child: ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: Container(
//                   width: 42,
//                   height: 42,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xffc4c4c4),
//                   ),
//                   child: Center(
//                     child: Image.asset(
//                       'assets/images/Group 30.png',
//                       height: 20,
//                       color: kPrimaryColor,
//                     ),
//                   ),
//                 ),
//                 title: MyText(
//                   text: 'Гость',
//                   size: 12,
//                   color: kDarkGreyColor,
//                   weight: FontWeight.w700,
//                   fontFamily: 'Roboto',
//                 ),
//                 subtitle: MyText(
//                   text: '17 янв в 15:00',
//                   size: 12,
//                   color: kInputBorderColor,
//                   fontFamily: 'Roboto',
//                 ),
//               ),
//             ),
//             MyText(
//               text: 'Отдам питомца',
//               size: 18,
//               weight: FontWeight.w700,
//               color: kSecondaryColor,
//               paddingLeft: 15,
//               paddingTop: 15,
//             ),
//             MyText(
//               text: 'Кошка по кличке неизвестно\nКому бенгалов?\nКонтакты',
//               size: 12,
//               fontFamily: 'Roboto',
//               color: kDarkGreyColor,
//               paddingLeft: 15,
//               paddingTop: 15,
//             ),
//             MyText(
//               text: 'Ссылка',
//               size: 12,
//               fontFamily: 'Roboto',
//               color: kSecondaryColor,
//               paddingLeft: 15,
//               paddingTop: 10,
//               paddingBottom: 10.0,
//             ),
//             logic.simplePostSave == true
//                 ? SizedBox(
//                     height: 353,
//                     child: Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: Image.asset(
//                               'assets/images/download 1.png',
//                               width: Get.width,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         logic.hidePopupAfterSavingKit == true ? const SizedBox() : showPopupAfterSavingKit(),
//                       ],
//                     ),
//                   )
//                 : SizedBox(
//                     height: 353,
//                     child: Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         PageView.builder(
//                           controller: logic.pageController,
//                           onPageChanged: logic.currentIndex,
//                           itemCount: 2,
//                           itemBuilder: (context, index) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5),
//                               child: Image.asset(
//                                 'assets/images/download 1.png',
//                                 width: Get.width,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Obx(() {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 15),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: List.generate(
//                                     2,
//                                     (index) => Container(
//                                       width: 6,
//                                       height: 6,
//                                       margin: const EdgeInsets.symmetric(horizontal: 3),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(100),
//                                         color: logic.currentIndex.value == index ? kPrimaryColor : kPrimaryColor.withOpacity(0.3),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//             logic.simplePostSave == false
//                 ? const SizedBox(
//                     height: 0,
//                   )
//                 : logic.storiesHandler == false
//                     ? const SizedBox(
//                         height: 10,
//                       )
//                     : GestureDetector(
//                         onTap: () => Get.bottomSheet(
//                           const SaveIntoSelectionKit(),
//                           backgroundColor: kPrimaryColor,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15),
//                             ),
//                           ),
//                           enableDrag: true,
//                         ),
//                         child: MyText(
//                           text: 'Сохранить в подборку',
//                           size: 14,
//                           color: kBlackColor,
//                           paddingLeft: 15,
//                           paddingTop: 10.0,
//                         ),
//                       ),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 15,
//                 top: logic.newSelectionKitSaved == true
//                     ? 15
//                     : logic.storiesHandler == false
//                         ? 15
//                         : 15,
//                 bottom: 15,
//                 right: 15,
//               ),
//               child: Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 alignment: WrapAlignment.spaceBetween,
//                 children: [
//                   Wrap(
//                     spacing: 22.0,
//                     children: [
//                       Image.asset(
//                         'assets/images/dark_grey_border_Heart.png',
//                         height: 20,
//                       ),
//                       GestureDetector(
//                         onTap: () => Get.to(() => const Comments()),
//                         child: Image.asset(
//                           'assets/images/comment.png',
//                           height: 20,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => Get.bottomSheet(
//                           const Share(),
//                           backgroundColor: kPrimaryColor,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15),
//                             ),
//                           ),
//                           enableDrag: true,
//                         ),
//                         child: Image.asset(
//                           'assets/images/share.png',
//                           height: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () => logic.simplySavePost(),
//                     child: Image.asset(
//                       logic.simplePostSave == true
//                           ? 'assets/images/Vector (16).png'
//                           : logic.storiesHandler == false
//                               ? 'assets/images/Vector (16).png'
//                               : 'assets/images/Save.png',
//                       height: logic.simplePostSave == true
//                           ? 20
//                           : logic.storiesHandler == false
//                               ? 20
//                               : 30,
//                       color: kDarkGreyColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => Get.to(
//                 () => Messages(
//                   title: 'Нравится',
//                 ),
//               ),
//               child: MyText(
//                 text: 'Нравится: 55',
//                 size: 12,
//                 weight: FontWeight.w700,
//                 fontFamily: 'Roboto',
//                 color: kDarkGreyColor,
//                 paddingLeft: 15,
//               ),
//             ),
//             GestureDetector(
//               onTap: () => Get.to(() => const Comments()),
//               child: MyText(
//                 text: 'Посмотреть все комментарии (2)',
//                 size: 12,
//                 fontFamily: 'Roboto',
//                 color: kInputBorderColor,
//                 paddingLeft: 15.0,
//                 paddingTop: 10.0,
//                 paddingBottom: 10.0,
//               ),
//             ),
//             ListTile(
//               onTap: () => Get.to(() => CommentOnPost()),
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.circular(100),
//                 child: Image.asset(
//                   'assets/images/profile.png',
//                   width: 37,
//                   height: 37,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               title: MyText(
//                 text: 'Добавьте комментарий',
//                 size: 12,
//                 color: kInputBorderColor,
//                 fontFamily: 'Roboto',
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget showPopupAfterSavingKit() {
//     return GetBuilder<EventsFeedController>(
//       init: EventsFeedController(),
//       builder: (logic) {
//         return GestureDetector(
//           onTap: () {
//             logic.hidePopup().then(
//                   (value) => Get.offAll(
//                     () => BottomNavBar(
//                       currentIndex: 1,
//                     ),
//                   ),
//                 );
//           },
//           child: Card(
//             margin: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 10,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(9),
//             ),
//             color: kPrimaryColor,
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 10,
//               ),
//               width: Get.width,
//               child: ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 5),
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(5),
//                   child: Image.asset(
//                     'assets/images/download 1.png',
//                     height: 54,
//                     width: 54,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 title: MyText(
//                   text: 'Сохранено в подборку “Купить”',
//                   size: 14,
//                   color: kBlackColor,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
