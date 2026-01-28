class QuestionModel {
  int? id;
  String? text;
  String? description;
  String? filePath;
  List<Answer>? answers;

  QuestionModel({
    this.id,
    this.text,
    this.description,
    this.filePath,
    this.answers,
  });

  // JSON dan obyektga
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      text: json['text'],
      description: json['description'],
      filePath: json['filePath'],
      answers: json['answers'] != null
          ? (json['answers'] as List).map((i) => Answer.fromJson(i)).toList()
          : [],
    );
  }

  // Obyektdan JSON ga
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'description': description,
      'filePath': filePath,
      'answers': answers?.map((v) => v.toJson()).toList(),
    };
  }
}

class Answer {
  int? id;
  bool isCorrect; // UI-da o'zgartirish uchun final emas
  String? text;

  Answer({
    this.id,
    this.isCorrect = false,
    this.text,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      isCorrect: json['isCorrect'] ?? false,
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isCorrect': isCorrect,
      'text': text,
    };
  }
}