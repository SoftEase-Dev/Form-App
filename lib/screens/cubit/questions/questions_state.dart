import 'package:form_app/data/model/question.dart';

abstract class QuestionState {}

class InitialQuestionState extends QuestionState {}

class LoadedQuestionState extends QuestionState {
  final List<Question> questions;

  LoadedQuestionState({required this.questions});
}

class ErrorQuestionState extends QuestionState {
  final String errorMessage;

  ErrorQuestionState({required this.errorMessage});
}
