import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/screens/cubit/submit_form/submit_form_cubit.dart';
import 'package:form_app/screens/widgets/custom_text_field.dart';
import 'package:form_app/themes/theme.dart';

class FormPage extends StatelessWidget {
  FormPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController ageController = TextEditingController(text: '');
  final TextEditingController weightController =
      TextEditingController(text: '');
  final TextEditingController heightController =
      TextEditingController(text: '');

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
        return CustomTextField(
          label: 'Nama Lengkap',
          hint: 'Masukan nama lengkap Anda',
          controller: nameController,
        );
      }

      Widget ageInput() {
        return CustomTextField(
          label: 'Usia (Tahun)',
          hint: 'Masukan usia Anda dalam tahun',
          controller: ageController,
        );
      }

      Widget weightInput() {
        return CustomTextField(
          label: 'Berat Badan (Kg)',
          hint: 'Masukan berat badan Anda dalam kg',
          controller: weightController,
        );
      }

      Widget heightInput() {
        return CustomTextField(
          label: 'Tinggi Badan (Cm)',
          hint: 'Masukan tinggi badan Anda dalam cm',
          controller: heightController,
        );
      }

      Widget submitButton(BuildContext context) {
        return ElevatedButton(
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 48)),
              backgroundColor: MaterialStateProperty.all(primary_500)),
          onPressed: () {
            BlocProvider.of<SubmitFormCubit>(context).submitForm(
              name: nameController.text,
              age: ageController.text,
              weight: weightController.text,
              height: heightController.text,
            );

            Navigator.pushNamed(context, '/quiz-page');
          },
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
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 32.0
                      : 24.0,
            ),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
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
                      submitButton(context),
                    ],
                  ),
                ),
              ],
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
          BlocProvider(
            create: (context) => SubmitFormCubit(),
            child: inputSection(),
          ),
        ],
      ),
    );
  }
}
