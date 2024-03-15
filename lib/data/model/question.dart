import 'dart:convert';

class Question {
  String type;
  String question;
  String answerA;
  String answerB;
  String image;

  Question({
    required this.type,
    required this.question,
    required this.answerA,
    required this.answerB,
    required this.image,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      question: json['questions'],
      answerA: json['answer_a'] ?? "",
      answerB: json['answer_b'] ?? "",
      image: json['image'] ?? "",
    );
  }
}

List<Question> questionsFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));
