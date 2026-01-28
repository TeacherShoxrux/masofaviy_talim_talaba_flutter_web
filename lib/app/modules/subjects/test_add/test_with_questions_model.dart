class TestWithQuestions {
  int? testId;
  List<Question>? questions;

  TestWithQuestions({this.testId, this.questions});

  factory TestWithQuestions.fromJson(Map<String, dynamic> json) {
    return TestWithQuestions(
      testId: json['testId'],
      questions: json['questions'] != null
          ? (json['questions'] as List).map((i) => Question.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'questions': questions?.map((v) => v.toJson()).toList(),
    };
  }
}

class Question {
  int? id;
  String? text;
  String? description;
  String? filePath;
  List<Answer>? answers;

  Question({
    this.id,
    this.text,
    this.description,
    this.filePath,
    this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      description: json['description'],
      filePath: json['filePath'],
      answers: json['answers'] != null
          ? (json['answers'] as List).map((i) => Answer.fromJson(i)).toList()
          : [],
    );
  }

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
  bool isCorrect;
  String? text;

  Answer({this.id, this.isCorrect = false, this.text});

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