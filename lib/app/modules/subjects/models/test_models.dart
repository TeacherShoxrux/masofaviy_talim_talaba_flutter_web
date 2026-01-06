class TestItem {
  final int id;
  final String icon;
  final String name;
  final String description;
  final int time;
  final int maxScore;

  TestItem({
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
    required this.time,
    required this.maxScore,
  });

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(
      id: json['id'],
      icon: json['icon'],
      name: json['name'],
      description: json['description'],
      time: json['time'],
      maxScore: json['maxScore'],
    );
  }
}
