class IndependentWork {
  final int id;
  final String name;
  final String description;
  final int maxScore;
  final String? files;
  final String references;

  IndependentWork({
    required this.id,
    required this.name,
    required this.description,
    required this.maxScore,
    this.files,
    required this.references,
  });

  factory IndependentWork.fromJson(Map<String, dynamic> json) {
    return IndependentWork(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      maxScore: json['maxScore'],
      files: json['files'],
      references: json['references'],
    );
  }
}
