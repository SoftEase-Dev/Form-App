import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/screens/cubit/answer/answer_cubit.dart';
import 'package:form_app/screens/cubit/questions/questions_cubit.dart';
import 'package:form_app/screens/cubit/result/result_cubit.dart';
import 'package:form_app/screens/cubit/submit_form/submit_form_cubit.dart';
import 'package:form_app/screens/pages/form_page.dart';
import 'package:form_app/screens/pages/home_page.dart';
import 'package:form_app/screens/pages/instruction_page.dart';
import 'package:form_app/screens/pages/quiz_page.dart';
import 'package:form_app/screens/pages/result_page.dart';
import 'package:form_app/themes/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // AppContext.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => QuestionCubit(context: context)),
        BlocProvider(create: (_) => AnswerCubit()),
        BlocProvider(create: (_) => SubmitFormCubit()),
        BlocProvider(create: (_) => ResultCubit()),
      ],
      child: MaterialApp(
        title: 'Form App',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
          '/form-page': (context) => FormPage(),
          '/instruction-page': (context) => const InstructionPage(),
          '/quiz-page': (context) => const QuizPageSecond(),
          '/result-page': (context) => const ResultPage(),
        },
      ),
    );
  }
}
