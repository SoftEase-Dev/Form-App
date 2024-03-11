import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/screens/widgets/custom_text_field.dart';
import 'package:form_app/themes/theme.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget background() {
      return SvgPicture.asset(
        'assets/svgs/home_bg.svg',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    Widget inputSection() {
      Widget title() {
        return Text(
          'Silahkan Masukan Data Anda',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: neutral_900, fontWeight: FontWeight.w900),
        );
      }

      Widget nameInput() {
        return const CustomTextField(
          label: 'Nama Lengkap',
          hint: 'Masukan nama lengkap Anda',
        );
      }

      Widget ageInput() {
        return const CustomTextField(
          label: 'Usia (Tahun)',
          hint: 'Masukan usia Anda dalam tahun',
        );
      }

      Widget weightInput() {
        return const CustomTextField(
          label: 'Berat Badan (Kg)',
          hint: 'Masukan berat badan Anda dalam kg',
        );
      }

      Widget heightInput() {
        return const CustomTextField(
          label: 'Tinggi Badan (Cm)',
          hint: 'Masukan tinggi badan Anda dalam cm',
        );
      }

      Widget submitButton() {
        return ElevatedButton(
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 48)),
              backgroundColor: MaterialStateProperty.all(primary_500)),
          onPressed: () {},
          child: Text(
            'Mulai',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: neutral_900, fontWeight: FontWeight.w900),
          ),
        );
      }

      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        'assets/svgs/back_button.svg',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        title(),
                        const SizedBox(height: 24),
                        nameInput(),
                        ageInput(),
                        weightInput(),
                        heightInput(),
                        const SizedBox(height: 16),
                        submitButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: primary_500,
      body: Stack(
        children: [
          background(),
          inputSection(),
        ],
      ),
    );
  }
}
