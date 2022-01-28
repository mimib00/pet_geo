class Users {
  /// User's UID
  final String? id;

  /// User's email
  final String email;

  /// User's name
  final String name;

  Users({
    this.id,
    this.email = '',
    this.name = '',
  });

  /// Craetes A Users object from a map.
  factory Users.fromMap(Map<String, dynamic> data, {String? id}) => Users(
        id: id,
        email: data["email"],
        name: data["name"] ?? "",
      );

  /// Creates a Map from a Users object.
  Map<String, dynamic> toMap() => {
        "id": id,
        "data": {
          "email": email,
          "name": name,
        }
      };
}
