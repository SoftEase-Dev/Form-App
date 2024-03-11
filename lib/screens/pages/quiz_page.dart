import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/data/model/answer.dart';
import 'package:form_app/data/model/question.dart';
import 'package:form_app/screens/cubit/answer/answer_cubit.dart';
import 'package:form_app/screens/cubit/questions/questions_cubit.dart';
import 'package:form_app/screens/cubit/questions/questions_state.dart';
import 'package:form_app/screens/widgets/option_item.dart';
import 'package:form_app/screens/widgets/step_bar.dart';
import 'package:form_app/themes/theme.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String conditionState = '';
  int stepNumber = 0;
  int questionsCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<QuestionCubit>(context).fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final answerCubit = BlocProvider.of<AnswerCubit>(context);

    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/imgs/bg_quiz.png',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            BlocBuilder<QuestionCubit, QuestionState>(
              builder: (context, state) {
                if (state is LoadedQuestionState) {
                  return Positioned(
                    top: 40,
                    right: 24,
                    left: 24,
                    child: StepBar(
                      stepNumber: stepNumber + 1,
                      questionsCount: state.questions.length,
                    ),
                  );
                } else {
                  return Positioned(
                    top: 40,
                    right: 24,
                    left: 24,
                    child: StepBar(
                      stepNumber: stepNumber + 1,
                      questionsCount: 10,
                    ),
                  );
                }
              },
            ),
            Positioned(
              top: 260,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: double.infinity,
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
                      return Container(
                        padding: EdgeInsets.only(left: 24, right: 24, top: 32),
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
                                  conditionState = 'a';
                                  answerCubit.updateAnswer(
                                      stepNumber, question.answerA);
                                });
                              },
                              child: OptionItem(
                                idOption: 'a',
                                conditionState: conditionState,
                                option: 'assets/svgs/a_option.svg',
                                question: question.answerA,
                                image: 'assets/imgs/option_img.png',
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  conditionState = 'b';
                                  answerCubit.updateAnswer(
                                      stepNumber, question.answerB);
                                });
                              },
                              child: OptionItem(
                                idOption: 'b',
                                conditionState: conditionState,
                                option: 'assets/svgs/b_option.svg',
                                question: question.answerB,
                                image: 'assets/imgs/option_img.png',
                              ),
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                    const Size(double.infinity, 48),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      conditionState.isNotEmpty
                                          ? primary_500
                                          : primary_100)),
                              onPressed: conditionState.isNotEmpty
                                  ? () {
                                      setState(() {
                                        stepNumber++;
                                        conditionState = '';
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
                                          color: conditionState.isNotEmpty
                                              ? black
                                              : neutral_500,
                                        ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: conditionState.isNotEmpty
                                        ? black
                                        : neutral_500,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (questionState is ErrorQuestionState) {
                      return Center(
                        child: Text('Error: ${questionState.errorMessage}'),
                      );
                    } else {
                      return Center(
                        child: Text('Press the button to fetch questions.'),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
