import 'package:bloc/bloc.dart';
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

    print('Name: $name');
    print('Age: $age');
    print('Weight: $weight');
    print('Height: $height');

    try {
      await Future.delayed(Duration(seconds: 2));

      emit(SubmitFormSuccess('Data berhasil disubmit'));
    } catch (e) {
      emit(SubmitFormFailure('Gagal mengirim data: $e'));
    }
  }
}
