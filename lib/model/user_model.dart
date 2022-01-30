class Users {
  /// User's UID
  final String? id;

  /// User's email
  final String email;

  /// User's name
  final String name;

  final String phone;

  final String photoUrl;

  final List pets;

  final List friends;

  Users({
    this.id,
    this.email = '',
    this.name = '',
    this.phone = '',
    this.friends = const [],
    this.pets = const [],
    this.photoUrl = '',
  });

  /// Craetes A Users object from a map.
  factory Users.fromMap(Map<String, dynamic> data, {String? id}) => Users(
        id: id,
        email: data["email"],
        name: data["name"] ?? "",
        phone: data["phone"] ?? "",
        photoUrl: data["photo"] ?? "",
        pets: data["pets"] ?? [],
        friends: data["friends"] ?? [],
      );

  /// Creates a Map from a Users object.
  Map<String, dynamic> toMap() => {
        "id": id,
        "data": {
          "email": email,
          "name": name,
          "photo": photoUrl,
          "pets": pets,
          "friends": friends,
          "phone": phone
        }
      };
}
