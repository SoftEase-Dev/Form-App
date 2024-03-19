import 'package:bloc/bloc.dart';
import 'package:form_app/data/model/submit_form.dart';
import 'package:meta/meta.dart';

part 'submit_form_state.dart';

class SubmitFormCubit extends Cubit<SubmitFormState> {
  SubmitFormCubit() : super(SubmitFormInitial());

  void submitForm({
    required String name,
    required String age,
    required String weight,
    required String height,
  }) async {
    emit(SubmitFormLoading());

    final submitForm = SubmitFormModel(
      name: name,
      age: age,
      weight: weight,
      height: height,
    );

    try {
      await Future.delayed(Duration(seconds: 2));

      emit(SubmitFormSuccess(submitFormModel: submitForm));
    } catch (e) {
      emit(SubmitFormFailure('Gagal mengirim data: $e'));
    }
    final currentState = this.state;
    if (currentState is SubmitFormSuccess) {
      final submitFormModel = currentState.submitFormModel;
      print(submitFormModel.name);
      print(submitFormModel.age);
      print(submitFormModel.weight);
      print(submitFormModel.height);
    }
  }
}
