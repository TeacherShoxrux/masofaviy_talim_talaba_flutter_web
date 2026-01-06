class ReferenceItem {
  final int id;
  final String name;
  final String description;
  final String reference;
  final int clickedCount;

  ReferenceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.reference,
    required this.clickedCount,
  });

  factory ReferenceItem.fromJson(Map<String, dynamic> json) {
    return ReferenceItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      reference: json['reference'],
      clickedCount: json['clickedCount'],
    );
  }
}
