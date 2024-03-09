import 'package:flutter/material.dart';
import 'package:form_app/screens/widgets/custom_text_field.dart';
import 'package:form_app/screens/widgets/option_item.dart';
import 'package:form_app/screens/widgets/step_bar.dart';
import 'package:form_app/themes/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary_500,
      child: Stack(
        children: [
          const Image(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            image: AssetImage('assets/imgs/home_bg.png'),
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Kuisioner',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: neutral_900, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pengukuran Beban Kognitif (NASA TLX)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 48),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(primary_500)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/test');
                    },
                    child: Text(
                      'Mulai',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: neutral_900, fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
