class CrossWord {
  final int id;
  final String name;
  final String description;
  final String icon;

  CrossWord({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory CrossWord.fromJson(Map<String, dynamic> json) {
    return CrossWord(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
