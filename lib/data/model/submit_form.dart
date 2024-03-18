import 'package:equatable/equatable.dart';

class SubmitFormModel extends Equatable {
  final String name;
  final String age;
  final String weight;
  final String height;

  SubmitFormModel({
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
  });

  @override
  List<Object?> get props => [name, age, weight, height];
}
