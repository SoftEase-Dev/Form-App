import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/data/model/answer.dart';
import 'package:form_app/screens/cubit/answer/answer_cubit.dart';
import 'package:form_app/screens/cubit/result/result_cubit.dart';
import 'package:form_app/screens/cubit/result/result_state.dart';
import 'package:form_app/screens/cubit/submit_form/submit_form_cubit.dart';
import 'package:form_app/themes/theme.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Color _getTextColor(double score) {
    if (score >= 0 && score <= 33.3) {
      return Color(0xFFDDF3C44);
    } else if (score > 33.3 && score <= 66.6) {
      return Color(0xFFE28C00);
    } else if (score > 66.6 && score <= 100) {
      return Color(0xFF9BD800);
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final resultCubit = BlocProvider.of<ResultCubit>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight =
        mediaQueryData.size.height - mediaQueryData.padding.top;
    double screenWidth = mediaQueryData.size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'SKOR HASIL',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  Text(
                    'NASA TLX',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: (screenWidth < 450)
                      ? screenHeight * 0.8
                      : screenHeight * 0.6,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: BlocBuilder<SubmitFormCubit, SubmitFormState>(
                        builder: (context, formState) {
                          if (formState is SubmitFormLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
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
                                    } else if (resultState
                                        is ErrorResultState) {
                                      return Center(
                                          child:
                                              Text(resultState.errorMessage));
                                    } else if (resultState
                                        is LoadedResultState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(36),
                                            child: AnimatedRadialGauge(
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.elasticOut,
                                              radius: 100,
                                              value:
                                                  resultState.resultData.scor,
                                              axis: const GaugeAxis(
                                                min: 0,
                                                max: 100,
                                                degrees: 290,
                                                style: GaugeAxisStyle(
                                                  thickness: 32,
                                                  background:
                                                      Colors.transparent,
                                                  segmentSpacing: 10,
                                                ),
                                                progressBar:
                                                    GaugeProgressBar.rounded(
                                                  color: Colors.transparent,
                                                ),
                                                segments: [
                                                  GaugeSegment(
                                                    from: 0,
                                                    to: 33.3,
                                                    gradient: GaugeAxisGradient(
                                                        colors: [
                                                          Color(0xFFDDF3C44),
                                                          Color(0xFFE28C00)
                                                        ]),
                                                    cornerRadius:
                                                        Radius.circular(4),
                                                  ),
                                                  GaugeSegment(
                                                    from: 33.3,
                                                    to: 66.6,
                                                    gradient: GaugeAxisGradient(
                                                        colors: [
                                                          Color(0xFFE28C00),
                                                          Color(0xFFEFD422)
                                                        ]),
                                                    cornerRadius:
                                                        Radius.circular(4),
                                                  ),
                                                  GaugeSegment(
                                                    from: 66.6,
                                                    to: 100,
                                                    gradient: GaugeAxisGradient(
                                                        colors: [
                                                          Color(0xFF9BD800),
                                                          Color(0xFF9BD800)
                                                        ]),
                                                    cornerRadius:
                                                        Radius.circular(4),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            resultState.resultData.scor
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                  color: _getTextColor(
                                                      resultState
                                                          .resultData.scor),
                                                ),
                                          ),
                                          Text(
                                            resultState.resultData.category,
                                            textAlign: TextAlign.end,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: _getTextColor(
                                                      resultState
                                                          .resultData.scor),
                                                ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            resultState.resultData.desc,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                  color: black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
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
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: neutral_300,
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 10,
                    ),
                  ],
                ),
                height: (screenWidth < 450)
                    ? screenHeight * 0.12
                    : screenHeight * 0.22,
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
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: neutral_900, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
