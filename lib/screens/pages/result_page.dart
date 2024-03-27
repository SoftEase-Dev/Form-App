// ignore_for_file: use_full_hex_values_for_flutter_colors

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
    if (score >= 0 && score <= 38) {
      return const Color(0xffddf3c44);
    } else if (score > 38 && score <= 54.66) {
      return const Color(0xFF9BD800);
    } else if (score > 54.66 && score <= 100) {
      return const Color(0xFFE28C00);
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
          margin: const EdgeInsets.only(top: 24),
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
                            return Center(
                                child: CircularProgressIndicator(
                              color: primary_500,
                            ));
                          } else if (formState is SubmitFormFailure) {
                            return Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: primary_500,
                                    size: 148,
                                  ),
                                  Text(
                                    formState.error,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  )
                                ],
                              ),
                            );
                          } else if (formState is SubmitFormSuccess) {
                            return BlocBuilder<AnswerCubit, List<Answer>>(
                              builder: (context, answerState) {
                                resultCubit.countResult(
                                    answerState, formState.submitFormModel);
                                return BlocBuilder<ResultCubit, ResultState>(
                                  builder: (context, resultState) {
                                    if (resultState is InitialResultState) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: primary_500,
                                      ));
                                    } else if (resultState
                                        is ErrorResultState) {
                                      return Center(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.warning_amber_rounded,
                                              color: primary_500,
                                              size: 148,
                                            ),
                                            Text(
                                              resultState.errorMessage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            )
                                          ],
                                        ),
                                      );
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
                                              builder:
                                                  (context, child, value) =>
                                                      Center(
                                                child: Text(
                                                  resultState.resultData.scor
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: _getTextColor(
                                                            resultState
                                                                .resultData
                                                                .scor),
                                                      ),
                                                ),
                                              ),
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
                                                    to: 38,
                                                    gradient: GaugeAxisGradient(
                                                        colors: [
                                                          Color(0xFFDDF3C44),
                                                          Color(0xFFE28C00)
                                                        ]),
                                                    cornerRadius:
                                                        Radius.circular(4),
                                                  ),
                                                  GaugeSegment(
                                                    from: 38,
                                                    to: 54.66,
                                                    gradient: GaugeAxisGradient(
                                                        colors: [
                                                          Color(0xFF9BD800),
                                                          Color(0xFF9BD800),
                                                        ]),
                                                    cornerRadius:
                                                        Radius.circular(4),
                                                  ),
                                                  GaugeSegment(
                                                    from: 54.66,
                                                    to: 100,
                                                    gradient: GaugeAxisGradient(
                                                        colors: [
                                                          Color(0xFFEFD422),
                                                          Color(0xFFE28C00),
                                                        ]),
                                                    cornerRadius:
                                                        Radius.circular(4),
                                                  ),
                                                ],
                                              ),
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
                                          const SizedBox(
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
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 38,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              Color(
                                                                  0xFFDDF3C44),
                                                              Color(0xFFE28C00)
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Overload',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: neutral_900,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                    ),
                                                    Text(
                                                      '0 - 38.00',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: neutral_400,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Container(
                                                  width: 1,
                                                  height: 60,
                                                  color: neutral_300,
                                                ),
                                                const Spacer(),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 38,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              Color(0xFF9BD800),
                                                              Color(0xFF9BD800),
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Optimal Load',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: neutral_900,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                    ),
                                                    Text(
                                                      '38.01 - 54.66',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: neutral_400,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Container(
                                                  width: 1,
                                                  height: 60,
                                                  color: neutral_300,
                                                ),
                                                const Spacer(),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 38,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              Color(0xFFEFD422),
                                                              Color(0xFFE28C00),
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Underload',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: neutral_900,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                    ),
                                                    Text(
                                                      '54.66 - 100',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                            color: neutral_400,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
