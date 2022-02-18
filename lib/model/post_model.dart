import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';
import 'package:pet_geo/model/ad_model.dart';

class PostModel {
  final String id;
  final String caption;
  final List likes;
  final List comments;
  final DocumentReference<Map<String, dynamic>>? owner;
  final Timestamp? createdAt;

  PostModel({
    this.id = '',
    this.caption = '',
    this.likes = const [],
    this.comments = const [],
    this.owner,
    this.createdAt,
  });
  factory PostModel.fromMap(Map<String, dynamic> data, String id) => PostModel(
        id: id,
        caption: data["caption"],
        likes: data["likes"] ?? [],
        comments: data["comments"] ?? [],
        owner: data["owner"],
        createdAt: data["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "caption": caption,
        "likes": likes,
        "coments": comments,
        "owner": owner,
        "created_at": createdAt
      };
  like() {
    AuthController controller = Get.find<AuthController>();
    var user = controller.user.value;
    if (user != null) {
      FirebaseFirestore.instance.collection('posts').doc(id).update(
        {
          "likes": FieldValue.arrayUnion([
            FirebaseFirestore.instance.collection("users").doc(user.id)
          ])
        },
      );
    }
  }

  unLike() {
    AuthController controller = Get.find<AuthController>();
    var user = controller.user.value;
    if (user != null) {
      FirebaseFirestore.instance.collection('posts').doc(id).update(
        {
          "likes": FieldValue.arrayRemove([
            FirebaseFirestore.instance.collection("users").doc(user.id)
          ])
        },
      );
    }
  }

  postComment(String text) {
    if (text.isNotEmpty) {
      AuthController controller = Get.find<AuthController>();
      var user = controller.user.value;
      Comment comment = Comment(
        text: text,
        owner: FirebaseFirestore.instance.collection('users').doc(user!.id!),
        createdAt: Timestamp.now(),
      );
      FirebaseFirestore.instance.collection('posts').doc(id).update(
        {
          "comments": FieldValue.arrayUnion(
            [
              comment.toMap()
            ],
          ),
        },
      );
    }
  }

  deleteComment(Comment comment) {
    FirebaseFirestore.instance.collection('posts').doc(id).update(
      {
        "comments": FieldValue.arrayRemove(
          [
            comment.toMap()
          ],
        )
      },
    );
  }
}
