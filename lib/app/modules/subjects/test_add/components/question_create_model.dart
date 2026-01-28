class QuestionCreateModel {
  final int testId;
  String text;
   String description;
   String filePath;
  final List<Answer> answers;

  QuestionCreateModel({
    required this.testId,
    required this.text,
    required this.description,
    required this.filePath,
    required this.answers,
  });

  // JSON-dan obyektga o'girish (Factory constructor)
  factory QuestionCreateModel.fromJson(Map<String, dynamic> json) {
    return QuestionCreateModel(
      testId: json['testId'] ?? 0,
      text: json['text'] ?? '',
      description: json['description'] ?? '',
      filePath: json['filePath'] ?? '',
      answers: (json['answers'] as List)
          .map((item) => Answer.fromJson(item))
          .toList(),
    );
  }

  // Obyektdan JSON-ga o'girish
  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'text': text,
      'description': description,
      'filePath': filePath,
      'answers': answers.map((item) => item.toJson()).toList(),
    };
  }
}

class Answer {
   bool isCorrect;
  final String text;

  Answer({
    required this.isCorrect,
    required this.text,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      isCorrect: json['isCorrect'] ?? false,
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isCorrect': isCorrect,
      'text': text,
    };
  }
}