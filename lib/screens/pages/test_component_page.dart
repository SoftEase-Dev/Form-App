import 'package:flutter/material.dart';
import 'package:form_app/screens/widgets/option_item.dart';
import 'package:form_app/screens/widgets/step_bar.dart';
import 'package:form_app/themes/theme.dart';

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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      conditionState = 'a';
                    });
                  },
                  child: OptionItem(
                    idOption: 'a',
                    conditionState: conditionState,
                    option: 'assets/svgs/a_option.svg',
                    question: "Bagaimana caranya?",
                    image: 'assets/imgs/option_img.png',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      conditionState = 'b';
                    });
                  },
                  child: OptionItem(
                    idOption: 'b',
                    conditionState: conditionState,
                    option: 'assets/svgs/b_option.svg',
                    question: "Bagaimana caranya?",
                    image: 'assets/imgs/option_img.png',
                  ),
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
                    icon: Icon(Icons.add))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
