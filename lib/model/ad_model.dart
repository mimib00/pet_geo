class Ad {
  final String? id;
  final String adType;
  final String animalType;
  final String gender;
  final String breed;
  final String nickname;
  final String comment;
  final String photoUrl;
  final String ownerId;
  final String color;
  final String age;
  final Map<String, dynamic> location;

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
    this.ownerId = '',
    this.location = const {},
  });

  factory Ad.fromMap(Map<String, dynamic> data, {String? id}) => Ad(
        id: id,
        nickname: data["nickname"] ?? 'Unknown',
        adType: data["ad_type"] ?? '',
        animalType: data['animal_type'] == null || data['animal_type'] == "Animal type" ? 'Unknown' : data['animal_type'],
        gender: data['gender'] == null || data['gender'] == "Gender" ? 'Unknown' : data['gender'],
        breed: data['breed'] == null || data['breed'] == "Breed" ? 'Unknown' : data['breed'],
        comment: data["comment"] ?? '',
        photoUrl: data["photo_url"] ?? '',
        color: data["color"] ?? '',
        ownerId: data["owner_id"] ?? '',
        location: data["location"] != null ? data["location"] as Map<String, dynamic> : {},
        age: data['age'] == null || data['age'] == "Animal type" ? 'Unknown' : data['age'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "data": {
          "nickname": nickname,
          "ad_type": adType,
          "animal_type": animalType,
          "gender": gender,
          "breed": breed,
          "comment": comment,
          "photo_url": photoUrl,
          "color": color,
          "age": age,
          "owner_id": ownerId,
          "location": location,
        }
      };
}
