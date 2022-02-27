import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/ad_model.dart';
import 'package:pet_geo/model/post_model.dart';
import 'package:pet_geo/model/user_model.dart';
import 'package:pet_geo/view/constant/constant.dart';
import 'package:pet_geo/view/drawer/my_drawer.dart';
import 'package:pet_geo/view/widget/custom_app_bar_2.dart';
import 'package:pet_geo/view/widget/my_text.dart';

class Comments extends StatefulWidget {
  final String? adId;
  final String? postId;
  // final List comments;
  final Ad? ad;
  final PostModel? post;
  const Comments({
    Key? key,
    this.adId,
    this.postId,
    final this.ad,
    final this.post,
  }) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  TextEditingController controller = TextEditingController();

  final CollectionReference<Map<String, dynamic>> _adRef = FirebaseFirestore.instance.collection("ads");
  final CollectionReference<Map<String, dynamic>> _postRef = FirebaseFirestore.instance.collection("posts");

  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];
    if (widget.adId != null) {
      var ads = await _adRef.doc(widget.adId).get();
      List temp = ads.data()!["comments"];
      for (var comment in temp) {
        comments.add(Comment.fromMap(comment));
      }
    } else if (widget.postId != null) {
      var posts = await _postRef.doc(widget.postId).get();
      List temp = posts.data()!["comments"];
      for (var comment in temp) {
        comments.add(Comment.fromMap(comment));
      }
    }
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const MyDrawer(),
      appBar: CustomAppBar2(
        haveSearch: false,
        haveTitle: true,
        onTitleTap: () {},
        showSearch: () {},
        title: 'Комментарии',
        globalKey: _key,
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Comment>>(
            future: getComments(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return Container();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var comment = snapshot.data![index];
                  return CommentTile(comment: comment);
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 45,
                color: kPrimaryColor,
                child: Center(
                  child: TextField(
                    controller: controller,
                    cursorColor: const Color(0xffBEBEBE),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      color: kDarkGreyColor,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (widget.ad != null) {
                            widget.ad!.postComment(controller.text.trim());
                            controller.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          } else if (widget.post != null) {
                            widget.post!.postComment(controller.text.trim());
                            controller.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 86,
                              height: 30,
                              child: Center(
                                child: MyText(
                                  text: 'Send'.toUpperCase(),
                                  size: 10,
                                  color: kDarkGreyColor,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Comment',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: Color(0xffBEBEBE),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          color: kSecondaryColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          color: kSecondaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final Comment comment;
  final Function()? onDelete;
  const CommentTile({
    Key? key,
    required this.comment,
    this.onDelete,
  }) : super(key: key);

  Future<Users> getOwner() async {
    var temp = await comment.owner!.get();
    return Users.fromMap(temp.data()!, id: temp.id);
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

          AuthController controller = Get.find<AuthController>();

          var owner = snapshot.data!;
          var time = DateFormat("MMMM d, H:m").format(comment.createdAt!.toDate());
          var user = controller.user.value!;

          return ListTile(
            onTap: () {},
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: owner.photoUrl,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: owner.name,
                  size: 16,
                  color: kDarkGreyColor,
                  fontFamily: 'Roboto',
                ),
                const SizedBox(height: 5),
                MyText(
                  text: comment.text,
                  size: 12,
                  color: kDarkGreyColor,
                  fontFamily: 'Roboto',
                ),
              ],
            ),
            subtitle: MyText(
              text: time,
              size: 12,
              color: kInputBorderColor,
              fontFamily: 'Roboto',
            ),
            trailing: Visibility(
              visible: owner.id == user.id,
              child: GestureDetector(
                onTap: onDelete,
                behavior: HitTestBehavior.opaque,
                child: const Icon(
                  Icons.delete,
                  color: kRedColor,
                ),
              ),
            ),
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

// ignore: must_be_immutable
class CommentsTiles extends StatelessWidget {
  const CommentsTiles({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Map<String, dynamic> comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          'personImage',
          height: 37,
          width: 37,
          fit: BoxFit.cover,
        ),
      ),
      title: MyText(
        text: 'comment',
        size: 12,
        color: kDarkGreyColor,
        fontFamily: 'Roboto',
      ),
      subtitle: MyText(
        text: 'time',
        size: 12,
        color: kInputBorderColor,
        fontFamily: 'Roboto',
      ),
      trailing: MyText(
        text: 'Ответить',
        size: 12,
        color: kInputBorderColor,
        fontFamily: 'Roboto',
        weight: FontWeight.w900,
      ),
    );
  }
}
