class UserModel {
  final int id;
  final String fullName;
  final String login;
  final String image;

  UserModel({
    required this.id,
    required this.fullName,
    required this.login,
    required this.image,
  });

  /// JSON → Object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      login: json['login'] as String,
      image: json['image'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'login': login,
      'image': image,
    };
  }
}
