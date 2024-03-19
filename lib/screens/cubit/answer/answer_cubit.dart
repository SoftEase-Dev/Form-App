import 'package:bloc/bloc.dart';
import 'package:form_app/data/model/answer.dart';

class AnswerCubit extends Cubit<List<Answer>> {
  AnswerCubit() : super([]);

  void generateAnswers(int length) {
    if (state.length == 0) {
      List<Answer> generatedAnswers = List.generate(
        length,
        (index) => Answer(number: index, answer: ""),
      );
      emit(generatedAnswers);
    }
  }

  void updateAnswer(int number, dynamic newAnswer) {
    final updatedAnswers = List<Answer>.from(state);
    // print(updatedAnswers.toString());

    updatedAnswers[number] = Answer(number: number, answer: newAnswer);

    // for (Answer answer in updatedAnswers) {
    //   print("Number: ${answer.number}, Answer: ${answer.answer}");
    // }
    emit(updatedAnswers);
  }
}
