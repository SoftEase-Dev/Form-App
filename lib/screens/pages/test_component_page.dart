import 'package:flutter/material.dart';
import 'package:form_app/screens/widgets/step_bar.dart';
import 'package:form_app/themes/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TestComponentPage extends StatefulWidget {
  const TestComponentPage({super.key});

  @override
  State<TestComponentPage> createState() => _TestComponentPageState();
}

class _TestComponentPageState extends State<TestComponentPage> {
  String conditionState = '';
  int stepNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form App"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Hello World!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: primary_600,
                      ),
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(neutral_200),
                    side: MaterialStateProperty.all(
                      BorderSide(color: neutral_300, width: 1.0),
                    ),
                  ),
                  child: Text(
                    'Hello World!',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: neutral_600,
                        ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 24,
                ),
                StepBar(
                  stepNumber: stepNumber,
                  questionsCount: 5,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (stepNumber < 18) {
                        stepNumber++;
                      }
                    });
                  },
                  icon: Icon(Icons.add),
                ),
                Container(
                  child: SfRadialGauge(
                    animationDuration: 5000,
                    enableLoadingAnimation: true,
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 38.00,
                              color: Colors.red),
                          GaugeRange(
                              startValue: 38.01,
                              endValue: 54.66,
                              color: Colors.orange),
                          GaugeRange(
                              startValue: 54.67,
                              endValue: 100,
                              color: Colors.green)
                        ],
                        pointers: <GaugePointer>[NeedlePointer(value: 33)],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Container(
                              child: Text(
                                '33',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.5,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
