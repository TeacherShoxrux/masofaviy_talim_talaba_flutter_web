class Student {}
class StudentModel {
  final int id;
  final String fullName;
  final String phone;
  final String image;
  final DateTime? dateOfBirth;

  const StudentModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.image,
    this.dateOfBirth,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'image': image,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }
}