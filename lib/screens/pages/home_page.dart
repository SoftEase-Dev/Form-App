import 'package:flutter/material.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
