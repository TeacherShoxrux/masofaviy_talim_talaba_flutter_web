class VideoLesson {
  final int id;
  final String icon;
  final String name;
  final String description;
  final String videoUrl;
  final int viewCount;

  VideoLesson({
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.viewCount,
  });

  factory VideoLesson.fromJson(Map<String, dynamic> json) {
    return VideoLesson(
      id: json['id'],
      icon: json['icon'],
      name: json['name'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      viewCount: json['viewCount'],
    );
  }
}
