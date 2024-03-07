import 'package:flutter/material.dart';
import 'package:form_app/screens/widgets/option_item.dart';
import 'package:form_app/themes/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form App"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
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
              OptionItem(
                option: 'assets/svgs/a_option.svg',
                question: "Bagaimana caranya?",
                image: 'assets/imgs/option_img.png',
              ),
              OptionItem(
                option: 'assets/svgs/b_option.svg',
                question: "Bagaimana caranya?",
                image: 'assets/imgs/option_img.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
