class SubjectModel {
  final int id;
  final String name;
  final String icon;
  final String description;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
    };
  }
}
