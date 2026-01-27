class VideoModel {
  final int id;
  final String icon;
  final String name;
  final String description;
  final String videoUrl;
  final int viewCount;

  VideoModel({
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.viewCount,
  });

  // JSON'dan obyektga o'girish (Factory)
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? 0,
      icon: json['icon'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      viewCount: json['viewCount'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'description': description,
      'videoUrl': videoUrl,
      'viewCount': viewCount,
    };
  }
  VideoModel copyWith({
    int? id,
    String? icon,
    String? name,
    String? description,
    String? videoUrl,
    int? viewCount,
  }) {
    return VideoModel(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      viewCount: viewCount ?? this.viewCount,
    );
  }
}