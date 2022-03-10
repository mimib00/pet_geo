// ignore_for_file: must_be_immutable

import 'package:advanced_stream_builder/advanced_stream_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/events_feed_controller/events_feed_controller.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/pet_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/animal_communities/animal_communities.dart';
import 'package:pet_geo/view/chat/likes_page.dart';
import 'package:pet_geo/view/bottom_sheets/options_for_user_profile.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/events_feed/list_view_type.dart';
import 'package:pet_geo/view/pets_profile/pets_profile.dart';
import 'package:pet_geo/view/user_profile/user_profile_profile_image/profile_image.dart';
import 'package:pet_geo/view/widget/logo.dart';
import 'package:pet_geo/view/widget/my_button.dart';
import 'package:pet_geo/view/widget/my_text.dart';
import 'package:http/http.dart' as http;
import 'package:pet_geo/view/widget/profile_picture.dart';
// import 'package:pet_geo/view/widget/profile_picture.dart';

class UserProfile extends StatefulWidget {
  final Users user;
  final bool isMe;
  const UserProfile({
    Key? key,
    required this.user,
    this.isMe = false,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final CollectionReference<Map<String, dynamic>> _postRef = FirebaseFirestore.instance.collection("posts");

  AuthController authController = Get.find<AuthController>();

  Future<List<Pet>> getPets() async {
    List<Pet> pets = [];
    for (DocumentReference<Map<String, dynamic>> pet in widget.user.pets) {
      var data = await pet.get();
      pets.add(Pet.fromMap(data.data()!, id: data.id));
    }
    return pets;
  }

  late bool invited;

  @override
  void initState() {
    invited = widget.user.invites.contains(FirebaseFirestore.instance.collection("users").doc(authController.user.value!.id));
    super.initState();
  }

  post(Map<String, dynamic> data) async {
    try {
      // post to firestore
      var snap = await _postRef.add(data);

      var poster = await snap.get();

      if (!poster.exists) throw "Post doesn't exists";

      // add to user list
      DocumentReference<Map<String, dynamic>> temp = data['owner'];
      temp.update({
        "posts": FieldValue.arrayUnion(
          [
            _postRef.doc(poster.id)
          ],
        )
      });
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        var user = controller.user.value!;
        return Scaffold(
          key: _key,
          drawer: const MyDrawer(),
          appBar: AppBar(
            toolbarHeight: 140,
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
            actions: const [
              SizedBox()
            ],
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
                minLeadingWidth: 70.0,
                title: GestureDetector(
                  onTap: () {},
                  child: MyText(
                    paddingRight: 35.0,
                    text: widget.user.name,
                    size: 18,
                    fontFamily: 'Roboto',
                    color: kPrimaryColor,
                    align: TextAlign.center,
                  ),
                ),
                trailing: Visibility(
                  visible: authController.user.value!.id! != widget.user.id!,
                  child: GestureDetector(
                    onTap: () => Get.bottomSheet(
                      OptionsForUserProfile(),
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
                      'assets/images/Settings.png',
                      height: 35,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            color: kLightGreyColor,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<List<Pet>>(
                      future: getPets(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 160,
                                    width: Get.width,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                                      itemCount: 0,
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container();
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20, top: 40),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 45,
                                              right: 15,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => Get.to(() => LikesPage(likes: const [])),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/Friends.png',
                                                        height: 30,
                                                      ),
                                                      MyText(
                                                        text: widget.user.friends.length,
                                                        size: 19,
                                                        weight: FontWeight.w700,
                                                        color: kSecondaryColor,
                                                        paddingLeft: 10.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => Get.to(() => AnimalCommunities()),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/Community.png',
                                                        height: 30,
                                                      ),
                                                      MyText(
                                                        text: 0,
                                                        size: 19,
                                                        weight: FontWeight.w700,
                                                        color: kSecondaryColor,
                                                        paddingLeft: 10.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: authController.user.value!.id != widget.user.id,
                                                  child: invited
                                                      ? MyButton(
                                                          onPressed: () async {
                                                            try {
                                                              var url = Uri.parse('https://europe-west2-petgeo-6f1ef.cloudfunctions.net/friend/cancel');
                                                              await http.post(url, body: {
                                                                "uid": authController.user.value!.id,
                                                                "friend": widget.user.id,
                                                              });
                                                              setState(() {
                                                                invited = false;
                                                              });
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
                                                          },
                                                          text: 'Cancel Request',
                                                          textSize: 12,
                                                          weight: FontWeight.w500,
                                                          btnBgColor: kSecondaryColor,
                                                          height: 30,
                                                          textColor: kPrimaryColor,
                                                          radius: 5.0,
                                                        )
                                                      : MyButton(
                                                          onPressed: () async {
                                                            try {
                                                              var url = Uri.parse('https://europe-west2-petgeo-6f1ef.cloudfunctions.net/friend/add');
                                                              var res = await http.post(url, body: {
                                                                "uid": authController.user.value!.id,
                                                                "friend": widget.user.id,
                                                              });

                                                              if (res.statusCode == 409) throw "Friend request has already been sent to this user";
                                                              setState(() {
                                                                invited = true;
                                                              });
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
                                                          },
                                                          text: 'Add Friend',
                                                          textSize: 12,
                                                          weight: FontWeight.w500,
                                                          btnBgColor: kSecondaryColor,
                                                          height: 30,
                                                          textColor: kPrimaryColor,
                                                          radius: 5.0,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (user.photoUrl.isNotEmpty) {
                                        Get.to(() => ProfileImage(photo: user.photoUrl));
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 15, top: 30),
                                      child: ProfilePicture(
                                        user: user,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 160,
                                  width: Get.width,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(horizontal: 2.5),
                                    itemCount: snapshot.data!.length,
                                    reverse: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var pet = snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () => Get.to(
                                          () => PetsProfile(
                                            pet: pet,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 2.5),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl: pet.photoUrl,
                                                  height: 79,
                                                  width: 79,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20, top: 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            top: 45,
                                            right: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () => Get.to(() => LikesPage(likes: const [])),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/Friends.png',
                                                      height: 30,
                                                    ),
                                                    MyText(
                                                      text: widget.user.friends.length,
                                                      size: 19,
                                                      weight: FontWeight.w700,
                                                      color: kSecondaryColor,
                                                      paddingLeft: 10.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.to(() => AnimalCommunities()),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/Community.png',
                                                      height: 30,
                                                    ),
                                                    MyText(
                                                      text: snapshot.data!.length,
                                                      size: 19,
                                                      weight: FontWeight.w700,
                                                      color: kSecondaryColor,
                                                      paddingLeft: 10.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Obx(
                                                () {
                                                  return authController.user.value!.invites.contains(FirebaseFirestore.instance.collection("users").doc(widget.user.id))
                                                      ? MyButton(
                                                          onPressed: () async {
                                                            try {
                                                              var url = Uri.parse('https://europe-west2-petgeo-6f1ef.cloudfunctions.net/friend/cancel');
                                                              var res = await http.post(url, body: {
                                                                "uid": authController.user.value!.id,
                                                                "friend": widget.user.id,
                                                              });
                                                              if (res.statusCode != 200) throw res.statusCode.toString();
                                                              authController.getUserData(authController.user.value!.id!);
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
                                                          },
                                                          text: 'Cancel Request',
                                                          textSize: 12,
                                                          weight: FontWeight.w500,
                                                          btnBgColor: kSecondaryColor,
                                                          height: 30,
                                                          textColor: kPrimaryColor,
                                                          radius: 5.0,
                                                        )
                                                      : MyButton(
                                                          onPressed: () async {
                                                            try {
                                                              var url = Uri.parse('https://europe-west2-petgeo-6f1ef.cloudfunctions.net/friend/add');
                                                              var res = await http.post(url, body: {
                                                                "uid": authController.user.value!.id,
                                                                "friend": widget.user.id,
                                                              });
                                                              if (res.statusCode != 200) throw res.statusCode.toString();
                                                              authController.getUserData(authController.user.value!.id!);
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
                                                          },
                                                          text: 'Add Friend',
                                                          textSize: 12,
                                                          weight: FontWeight.w500,
                                                          btnBgColor: kSecondaryColor,
                                                          height: 30,
                                                          textColor: kPrimaryColor,
                                                          radius: 5.0,
                                                        );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (user.photoUrl.isNotEmpty) {
                                      Get.to(() => ProfileImage(photo: user.photoUrl));
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15, top: 30),
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.user.photoUrl,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          margin: const EdgeInsets.only(left: 15, top: 30),
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            border: Border.all(
                                              color: kLightGreyColor,
                                              width: 3.0,
                                            ),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/Group 30.png',
                                              height: 45,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  Visibility(
                    visible: user.id == widget.user.id,
                    child: Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 0,
                      child: Container(
                        height: 56,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Center(
                          child: TextField(
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                // post to firestore
                                Map<String, dynamic> data = {
                                  "caption": value,
                                  "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
                                  "likes": [],
                                  "comments": [],
                                  "created_at": FieldValue.serverTimestamp()
                                };

                                post(data);
                              }
                            },
                            cursorColor: kInputBorderColor.withOpacity(0.5),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kLightGreyColor,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kLightGreyColor,
                                  width: 2.0,
                                ),
                              ),
                              hintText: 'What\'s on your mind?',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                color: kInputBorderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<EventsFeedController>(
                      builder: (event) {
                        return AdvancedStreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          streams: event.getUserPosts(widget.user),
                          builder: (context, snapshots) {
                            if (snapshots.data == null) return Container();
                            if (snapshots.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            var temp = snapshots.data?.asMap();
                            if (temp == null) return Container();
                            var ads = temp[0];
                            var posts = temp[1];

                            if (event.posts.isEmpty) {
                              for (var ad in ads!.docs) {
                                event.makeAdsPosts(ad);
                              }
                              for (var post in posts!.docs) {
                                event.makeUserPost(post);
                              }
                            }

                            return ListView.builder(
                              padding: const EdgeInsets.only(
                                bottom: 30,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount: event.posts.length,
                              itemBuilder: (context, index) {
                                var post = event.posts[index];
                                return Post(post: post);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
