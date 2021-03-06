import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String? id;
  final String name;
  final String photoUrl;
  final String type;
  final String gender;
  final int weight;
  final bool sterilization;
  final String color;
  final String birthYear;
  final DocumentReference<Map<String, dynamic>>? ownerId;
  final List tagedPosts;
  final Map<String, dynamic> location;

  Pet({
    this.id,
    this.name = '',
    this.photoUrl = '',
    this.type = '',
    this.gender = '',
    this.weight = 0,
    this.sterilization = false,
    this.color = '',
    this.birthYear = '',
    this.ownerId,
    this.tagedPosts = const [],
    this.location = const {},
  });

  /// Craetes A Users object from a map.
  factory Pet.fromMap(Map<String, dynamic> data, {String? id}) => Pet(
        id: id,
        type: data["type"] = '',
        name: data["name"] ?? "",
        gender: data["gender"] ?? "",
        photoUrl: data["photo"] ?? "",
        weight: data["weight"] ?? 0.0,
        sterilization: data["sterilization"] ?? false,
        color: data["color"] ?? "",
        birthYear: data["year"] ?? "",
        ownerId: data["owner_id"] ?? "",
        tagedPosts: data["posts"] ?? [],
        location: data["location"] ?? {},
      );

  /// Creates a Map from a Users object.
  Map<String, dynamic> toMap() => {
        "id": id,
        "data": {
          "type": type,
          "name": name,
          "photo": photoUrl,
          "gender": gender,
          "weight": weight,
          "sterilization": sterilization,
          "color": color,
          "year": birthYear,
          "owner_id": ownerId,
          "posts": tagedPosts,
          "location": location
        }
      };
}
