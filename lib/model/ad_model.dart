import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_geo/controller/user_controller/auth_controller.dart';

class Ad {
  final String? id;
  final String adType;
  final String animalType;
  final String gender;
  final String breed;
  final String nickname;
  final String comment;
  final String photoUrl;
  final DocumentReference<Map<String, dynamic>>? owner;
  final String color;
  final String age;
  final Map<String, dynamic> location;
  final List likes;
  final List comments;
  final Timestamp? createdAt;

  Ad({
    this.id,
    this.adType = '',
    this.animalType = '',
    this.gender = '',
    this.breed = '',
    this.nickname = '',
    this.comment = '',
    this.photoUrl = '',
    this.color = '',
    this.age = '',
    this.owner,
    this.location = const {},
    this.comments = const [],
    this.likes = const [],
    this.createdAt,
  });

  factory Ad.fromMap(Map<String, dynamic> data) => Ad(
        id: data["id"],
        nickname: data["nickname"] ?? 'Unknown',
        adType: data["ad_type"] ?? '',
        animalType: data['animal_type'] == null || data['animal_type'] == "Animal type" ? 'Unknown' : data['animal_type'],
        gender: data['gender'] == null || data['gender'] == "Gender" ? 'Unknown' : data['gender'],
        breed: data['breed'] == null || data['breed'] == "Breed" ? 'Unknown' : data['breed'],
        comment: data["comment"] ?? '',
        photoUrl: data["photo_url"] ?? '',
        color: data["color"] ?? '',
        owner: data["owner"] ?? '',
        location: data["location"] != null ? data["location"] as Map<String, dynamic> : {},
        age: data['age'] == null || data['age'] == "Animal type" ? 'Unknown' : data['age'],
        likes: data["likes"] ?? [],
        comments: data["likes"] ?? [],
        createdAt: data["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nickname": nickname,
        "ad_type": adType,
        "animal_type": animalType,
        "gender": gender,
        "breed": breed,
        "comment": comment,
        "photo_url": photoUrl,
        "color": color,
        "age": age,
        "owner": owner,
        "location": location,
        "likes": likes,
        "comments": comments,
        "created_at": createdAt,
      };

  like() {
    AuthController controller = Get.find<AuthController>();
    var user = controller.user.value;
    if (user != null) {
      FirebaseFirestore.instance.collection('ads').doc(id).update(
        {
          "likes": FieldValue.arrayUnion([
            user.id
          ])
        },
      );
    }
  }

  unLike() {
    AuthController controller = Get.find<AuthController>();
    var user = controller.user.value;
    if (user != null) {
      FirebaseFirestore.instance.collection('ads').doc(id).update(
        {
          "likes": FieldValue.arrayRemove([
            user.id
          ])
        },
      );
    }
  }

  postComment(String text) {
    AuthController controller = Get.find<AuthController>();
    var user = controller.user.value;
    Comment comment = Comment(
      text: text,
      owner: FirebaseFirestore.instance.collection('users').doc(user!.id!),
      createdAt: Timestamp.now(),
    );
    if (id != null && text.isNotEmpty) {
      FirebaseFirestore.instance.collection('ads').doc(id).update(
        {
          "comments": FieldValue.arrayUnion(
            [
              comment.toMap()["data"]
            ],
          ),
        },
      );
    }
  }
}

class Comment {
  final String? id;
  final DocumentReference<Map<String, dynamic>>? owner;
  final String text;
  final Timestamp? createdAt;

  Comment({
    this.id,
    this.owner,
    this.text = '',
    this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> data, {String? id}) => Comment(
        id: id,
        owner: data["owner"],
        text: data["text"],
        createdAt: data["created_at"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "data": {
          "text": text,
          "owner": owner,
          "created_at": createdAt,
        }
      };
}
