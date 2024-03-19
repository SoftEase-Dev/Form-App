import 'package:form_app/data/model/result.dart';

abstract class ResultState {}

class InitialResultState extends ResultState {}

class LoadedResultState extends ResultState {
  final Result resultData;

  LoadedResultState({required this.resultData});
}

class ErrorResultState extends ResultState {
  final String errorMessage;

  ErrorResultState({required this.errorMessage});
}
