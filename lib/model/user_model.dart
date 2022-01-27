class Users {
  /// User's UID
  final String? id;

  /// User's email
  final String email;

  Users(this.id, this.email);

  /// Craetes A Users object from a map.
  factory Users.fromMap(Map<String, dynamic> data, {String? id}) => Users(id, data["email"]);

  /// Creates a Map from a Users object.
  Map<String, dynamic> toMap() => {
        "id": id,
        "data": {
          "email": email,
        }
      };
}
