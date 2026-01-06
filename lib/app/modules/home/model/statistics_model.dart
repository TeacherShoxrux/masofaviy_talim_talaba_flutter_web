class StatisticsModel {
  final int subjectsCount;
  final int videosCount;
  final int independentWorkCount;
  final int testsCount;

  const StatisticsModel({
    required this.subjectsCount,
    required this.videosCount,
    required this.independentWorkCount,
    required this.testsCount,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      subjectsCount: json['subjectsCount'] ?? 0,
      videosCount: json['videosCount'] ?? 0,
      independentWorkCount: json['independentWorkCount'] ?? 0,
      testsCount: json['testsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectsCount': subjectsCount,
      'videosCount': videosCount,
      'independentWorkCount': independentWorkCount,
      'testsCount': testsCount,
    };
  }
}
