import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/data/model/answer.dart';
import 'package:form_app/screens/cubit/answer/answer_cubit.dart';
import 'package:form_app/screens/cubit/result/result_cubit.dart';
import 'package:form_app/screens/cubit/result/result_state.dart';
import 'package:form_app/screens/cubit/submit_form/submit_form_cubit.dart';
import 'package:form_app/themes/theme.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final resultCubit = BlocProvider.of<ResultCubit>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight =
        mediaQueryData.size.height - mediaQueryData.padding.top;
    double screenWidth = mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:
            (screenWidth < 450) ? screenHeight * 0.08 : screenHeight * 0.18,
        automaticallyImplyLeading: false,
        title: Text('Hasil Skor',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w900),
            textAlign: TextAlign.center),
        centerTitle: true,
        shadowColor: neutral_400,
        backgroundColor: white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.white,
            height:
                (screenWidth < 450) ? screenHeight * 0.8 : screenHeight * 0.6,
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<SubmitFormCubit, SubmitFormState>(
                  builder: (context, formState) {
                    if (formState is SubmitFormLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (formState is SubmitFormFailure) {
                      return Center(
                        child: Text(formState.error),
                      );
                    } else if (formState is SubmitFormSuccess) {
                      return BlocBuilder<AnswerCubit, List<Answer>>(
                        builder: (context, answerState) {
                          resultCubit.countResult(
                              answerState, formState.submitFormModel);
                          return BlocBuilder<ResultCubit, ResultState>(
                            builder: (context, resultState) {
                              if (resultState is InitialResultState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (resultState is ErrorResultState) {
                                return Center(
                                    child: Text(resultState.errorMessage));
                              } else if (resultState is LoadedResultState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        resultState.resultData.scor.toString()),
                                    Text(resultState.resultData.category)
                                  ],
                                );
                              }
                              return const Center(child: Text('Error'));
                            },
                          );
                        },
                      );
                    }
                    return const Center(
                      child: Text('Gagal mendapatkan data user'),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color:
                      neutral_300, // Set the shadow color to blue with 0.2 opacity
                  offset:
                      const Offset(2.0, 2.0), // Set the offset of the shadow
                  blurRadius: 10,
                ),
              ],
            ),
            height:
                (screenWidth < 450) ? screenHeight * 0.12 : screenHeight * 0.22,
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 48),
                ),
                backgroundColor: MaterialStateProperty.all(primary_500),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Kembali ke Beranda',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: neutral_900, fontWeight: FontWeight.w900),
              ),
            ),
          )
        ],
      ),
    );
  }
}
