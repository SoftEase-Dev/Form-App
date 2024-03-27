import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/screens/cubit/answer/answer_cubit.dart';
import 'package:form_app/screens/cubit/questions/questions_cubit.dart';
import 'package:form_app/screens/cubit/questions/questions_state.dart';
import 'package:form_app/screens/widgets/option_item.dart';
import 'package:form_app/screens/widgets/step_bar.dart';
import 'package:form_app/themes/theme.dart';

class QuizPageSecond extends StatefulWidget {
  const QuizPageSecond({super.key});

  @override
  State<QuizPageSecond> createState() => _QuizPageSecondState();
}

class _QuizPageSecondState extends State<QuizPageSecond> {
  bool? conditionState = null;
  int stepNumber = 0;
  int questionsCount = 0;
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _textEditingController = TextEditingController();

  String userInput = '';

  bool _checkInputFilled() {
    return _textEditingController.text.isNotEmpty;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<QuestionCubit>(context).fetchQuestions();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final answerCubit = BlocProvider.of<AnswerCubit>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/imgs/bg_quiz.png'),
                fit: BoxFit.fitWidth),
          ),
          child: Column(
            children: [
              BlocBuilder<QuestionCubit, QuestionState>(
                builder: (context, state) {
                  if (state is LoadedQuestionState) {
                    return Container(
                      margin:
                          const EdgeInsets.only(top: 40, right: 20, left: 20),
                      child: StepBar(
                        stepNumber: stepNumber + 1,
                        questionsCount: state.questions.length,
                      ),
                    );
                  } else {
                    return StepBar(
                      stepNumber: stepNumber + 1,
                      questionsCount: 10,
                    );
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 40),
                margin: const EdgeInsets.only(top: 160),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: BlocBuilder<QuestionCubit, QuestionState>(
                  builder: (context, questionState) {
                    if (questionState is LoadedQuestionState) {
                      answerCubit
                          .generateAnswers(questionState.questions.length);
                      final question = questionState.questions[stepNumber];
                      if (question.type == "multiple") {
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 32),
                          child: Column(
                            children: [
                              Text(
                                question.question,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 40),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    conditionState = true;
                                    answerCubit.updateAnswer(stepNumber, true);
                                  });
                                },
                                child: OptionItem(
                                  idOption: true,
                                  conditionState: conditionState,
                                  option: 'assets/svgs/a_option.svg',
                                  question: question.answerA,
                                  image: question.imageA,
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    conditionState = false;
                                    answerCubit.updateAnswer(stepNumber, false);
                                  });
                                },
                                child: OptionItem(
                                  idOption: false,
                                  conditionState: conditionState,
                                  option: 'assets/svgs/b_option.svg',
                                  question: question.answerB,
                                  image: question.imageB,
                                ),
                              ),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                    const Size(double.infinity, 48),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    conditionState != null
                                        ? primary_500
                                        : primary_100,
                                  ),
                                ),
                                onPressed: conditionState != null
                                    ? () {
                                        setState(() {
                                          stepNumber++;
                                          conditionState = null;
                                        });
                                      }
                                    : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Selanjutnya',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: conditionState != null
                                                ? black
                                                : neutral_500,
                                          ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: conditionState != null
                                          ? black
                                          : neutral_500,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (question.type == "input") {
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Berikan penilaian skala 0-100 dari pernyataan yang menggambarkan pekerjaan Anda.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  height: 176,
                                  alignment: Alignment.bottomLeft,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          question.image,
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              black.withOpacity(.4),
                                              Colors.transparent
                                            ],
                                            stops: [0.5, 1.0],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        margin: EdgeInsets.only(
                                            left: 20, bottom: 20),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            question.question,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  foreground: Paint()
                                                    ..shader =
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFEF8633),
                                                        Color(0xFFEEC049)
                                                      ],
                                                    ).createShader(
                                                            const Rect.fromLTWH(
                                                                0.0,
                                                                0.0,
                                                                200.0,
                                                                70.0)),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Jawaban Anda',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextField(
                                  controller: _textEditingController,
                                  onChanged: (value) {
                                    setState(() {});
                                    userInput = value;
                                  },
                                  cursorColor: Colors.grey,
                                  style: Theme.of(context).textTheme.labelLarge,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 20,
                                    ),
                                    filled: true,
                                    fillColor: neutral_50,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: primary_500,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                      const Size(double.infinity, 48),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      _checkInputFilled()
                                          ? primary_500
                                          : primary_100,
                                    ),
                                  ),
                                  onPressed: _checkInputFilled()
                                      ? () {
                                          if (userInput.isNotEmpty) {
                                            int inputNumber =
                                                int.tryParse(userInput) ?? -1;
                                            if (inputNumber >= 0 &&
                                                inputNumber <= 100) {
                                              BlocProvider.of<AnswerCubit>(
                                                      context)
                                                  .updateAnswer(
                                                      stepNumber, userInput);
                                              _textEditingController.clear();
                                              userInput = '';
                                              if (stepNumber <
                                                  questionState
                                                          .questions.length -
                                                      1) {
                                                setState(() {
                                                  stepNumber++;
                                                });
                                              } else {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/result-page',
                                                        (route) =>
                                                            route.settings
                                                                    .name ==
                                                                '/' ||
                                                            route.settings
                                                                    .name ==
                                                                null);
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Isi angka dari 0 - 100'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      : null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Selanjutnya',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: _checkInputFilled()
                                                  ? black
                                                  : neutral_500,
                                            ),
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: _checkInputFilled()
                                            ? black
                                            : neutral_500,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    } else if (questionState is ErrorQuestionState) {
                      return Center(
                        child: Text('Error: ${questionState.errorMessage}'),
                      );
                    }
                    return const Center(
                      child: Text('Press the button to fetch questions.'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
