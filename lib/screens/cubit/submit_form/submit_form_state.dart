part of 'submit_form_cubit.dart';

@immutable
abstract class SubmitFormState {}

class SubmitFormInitial extends SubmitFormState {}

class SubmitFormLoading extends SubmitFormState {}

class SubmitFormSuccess extends SubmitFormState {
  final String message;

  SubmitFormSuccess(this.message);
}

class SubmitFormFailure extends SubmitFormState {
  final String error;

  SubmitFormFailure(this.error);
}
