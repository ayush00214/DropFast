class UserModel {
  final String id;
  final String uid;
  final String email;
  final String name;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? "",           // backend sends "_id"
      uid: json["uid"] ?? "",
      email: json["email"] ?? "",
      name: json["name"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}