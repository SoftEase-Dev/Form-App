import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:form_app/data/model/question.dart';
import 'package:form_app/screens/cubit/questions/questions_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final BuildContext context;

  QuestionCubit({required this.context}) : super(InitialQuestionState());

  void fetchQuestions() async {
    try {
      final response = await DefaultAssetBundle.of(context)
          .loadString('assets/questions.json');
      final List<Question> questions = questionsFromJson(response);
      emit(LoadedQuestionState(questions: questions));
    } catch (e) {
      emit(ErrorQuestionState(errorMessage: 'An error occurred'));
    }
  }
}
