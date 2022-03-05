// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/folder_model.dart';
import 'package:pet_geo/model/post_model.dart';
import 'package:pet_geo/model/story_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/packages/advanced_stream_builder/lib/src/advanced_builder.dart';
import 'package:pet_geo/view/bottom_sheets/share.dart';
import 'package:pet_geo/view/chat/likes_page.dart';
import 'package:pet_geo/view/comments/comments.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/stories/create_story.dart';
import 'package:pet_geo/view/user_profile/user_profile_with_offer_help.dart';
import 'package:pet_geo/view/widget/folder_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:pet_geo/view/widget/profile_picture.dart';

class ListViewType extends StatelessWidget {
  const ListViewType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsFeedController>(
      init: EventsFeedController(),
      builder: (controller) {
        final AuthController authController = Get.find<AuthController>();
        return AdvancedStreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          streams: controller.getPostsStream(),
          builder: (context, snapshot) {
            if (snapshot.data == null || snapshot.data!.isEmpty) return Container();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var temp = snapshot.data?.asMap();
            if (temp == null) return Container();
            var ads = temp[0];
            var posts = temp[1];

            if (controller.posts.isEmpty) {
              if (ads != null && ads.docs.isNotEmpty) {
                for (var ad in ads.docs) {
                  controller.makeAdsPosts(ad);
                }
              }
              if (posts != null && posts.docs.isNotEmpty) {
                for (var post in posts.docs) {
                  controller.makeUserPost(post);
                }
              }
            }
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: Get.width,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: GestureDetector(
                          onTap: () => Get.to(() => const CreateStory()),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kGreenColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: authController.user.value!.photoUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: SizedBox(
                          height: 70,
                          child: FutureBuilder<List<Story>>(
                            future: controller.getStories(),
                            builder: (context, snapshot) => ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              itemCount: controller.stories.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // return GestureDetector(
                                //   onTap: storiesData.onTap,
                                //   child: Container(
                                //     margin: const EdgeInsets.symmetric(horizontal: 7),
                                //     height: 70,
                                //     width: 70,
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     color: storiesData.haveNewStory == true ? kGreenColor : Colors.transparent,
                                //     width: 2.0,
                                //   ),
                                //   borderRadius: BorderRadius.circular(100),
                                // ),
                                //     child: ClipRRect(
                                //       borderRadius: BorderRadius.circular(100),
                                //       child: Image.asset(
                                //         '${storiesData.storyContent}',
                                //         fit: BoxFit.cover,
                                //         height: Get.height,
                                //       ),
                                //     ),
                                //   ),
                                // );

                                return StoryTile(onTap: () {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      var post = controller.posts[index];
                      return Post(post: post);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
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
      case "PostModel":
        child = UserPost(post: post);
        break;
      default:
    }
    return child;
  }
}

class UserPost extends StatefulWidget {
  final PostModel post;
  const UserPost({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  Future<Users> getOwner() async {
    var temp = await widget.post.owner!.get();
    return Users.fromMap(temp.data()!, id: temp.id);
  }

  late bool isLiked = false;

  @override
  void initState() {
    AuthController controller = Get.find<AuthController>();
    isLiked = widget.post.likes.contains(FirebaseFirestore.instance.collection("users").doc(controller.user.value!.id!));
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
          var time = DateFormat("MMMM d, H:m").format(widget.post.createdAt!.toDate());
          Widget type = const Text('');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(() => UserProfile(user: owner));
                },
                child: Container(
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
                    leading: ProfilePicture(
                      user: owner,
                      height: 42,
                      width: 42,
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
              ),
              type,
              MyText(
                text: widget.post.caption,
                size: 14,
                fontFamily: 'Roboto',
                color: kDarkGreyColor,
                paddingLeft: 15,
                paddingTop: 15,
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
                              widget.post.unLike();
                              setState(() {
                                isLiked = false;
                              });
                            } else {
                              widget.post.like();
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
                              postId: widget.post.id,
                              post: widget.post,
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
              GestureDetector(
                onTap: () => Get.to(() => LikesPage(likes: widget.post.likes)),
                child: MyText(
                  text: 'Нравится: ${widget.post.likes.length}',
                  size: 12,
                  weight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  color: kDarkGreyColor,
                  paddingLeft: 15,
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
      },
    );
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
  late bool isSaved = false;
  @override
  void initState() {
    AuthController controller = Get.find<AuthController>();
    isLiked = widget.ad.likes.contains(FirebaseFirestore.instance.collection("users").doc(controller.user.value!.id!));
    saved();
    super.initState();
  }

  saved() async {
    isSaved = await logic.postSaved(FirebaseFirestore.instance.collection("ads").doc(widget.ad.id));
  }

  final EventsFeedController logic = Get.put<EventsFeedController>(EventsFeedController());
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
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => UserProfile(user: owner));
                  },
                  child: Container(
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
                      leading: ProfilePicture(
                        user: owner,
                        height: 42,
                        width: 42,
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
                                adId: widget.ad.id,
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
                        onTap: () {
                          Get.bottomSheet(
                            SaveFolders(
                              ad: widget.ad,
                            ),
                            backgroundColor: kPrimaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            enableDrag: true,
                          );
                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                        child: Icon(
                          isSaved == true ? Icons.bookmark : Icons.bookmark_outline,
                          size: 30,
                          color: kDarkGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => LikesPage(likes: widget.ad.likes)),
                  child: MyText(
                    text: 'Нравится: ${widget.ad.likes.length}',
                    size: 12,
                    weight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    color: kDarkGreyColor,
                    paddingLeft: 15,
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

class SaveFolders extends StatelessWidget {
  final Ad ad;

  SaveFolders({
    Key? key,
    required this.ad,
  }) : super(key: key);
  final EventsFeedController logic = Get.find<EventsFeedController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>?>(
      future: logic.getFolders(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return Container();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var data = snapshot.data!.docs;
        return Column(
          children: [
            AddFolder(),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var folder = Folder(
                    id: data[index].id,
                    name: data[index].data()["name"],
                    posts: data[index].data()["posts"].cast<DocumentReference<Map<String, dynamic>>>(),
                  );
                  return FolderButton(
                    folder: folder,
                    post: FirebaseFirestore.instance.collection("ads").doc(ad.id),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class StoryTile extends StatelessWidget {
  final Function()? onTap;
  const StoryTile({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: kGreenColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
