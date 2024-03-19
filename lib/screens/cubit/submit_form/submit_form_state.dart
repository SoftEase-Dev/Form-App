part of 'submit_form_cubit.dart';

@immutable
abstract class SubmitFormState {}

class SubmitFormInitial extends SubmitFormState {}

class SubmitFormLoading extends SubmitFormState {}

class SubmitFormSuccess extends SubmitFormState {
  final SubmitFormModel submitFormModel;

  SubmitFormSuccess({required this.submitFormModel});
}

class SubmitFormFailure extends SubmitFormState {
  final String error;

  SubmitFormFailure(this.error);
}
