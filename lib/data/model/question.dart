import 'dart:convert';

class Question {
  String type;
  String question;
  String answerA;
  String answerB;
  String image;
  String imageA;
  String imageB;

  Question({
    required this.type,
    required this.question,
    required this.answerA,
    required this.answerB,
    required this.image,
    required this.imageA,
    required this.imageB,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      question: json['questions'],
      answerA: json['answer_a'] ?? "",
      answerB: json['answer_b'] ?? "",
      image: json['image'] ?? "",
      imageA: json['image_a'] ?? "",
      imageB: json['image_b'] ?? "",
    );
  }
}

List<Question> questionsFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));
