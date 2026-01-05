class SessionModel {
  final int id;
  final String fullName;
  final String role;
  final String accessToken;
  final String refreshToken;
  final DateTime expireTime;

  SessionModel({
    required this.id,
    required this.fullName,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
    required this.expireTime,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      fullName: json['fullName'],
      role: json['role'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expireTime: DateTime.parse(json['expireTime']),
    );
  }
}
