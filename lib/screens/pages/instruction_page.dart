import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/themes/theme.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: white,
        elevation: 8,
        surfaceTintColor: white,
        title: Text(
          'Instruksi Pengisian NASA-TLX',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: black,
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/svgs/back_button.svg'),
          iconSize: 32,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }

    Widget bagian1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terdapat 2 bagian dalam menyelesaikan evaluasi ini.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: black,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Bagian 1',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Komparasi antara dua pernyataan. Pilih salah satu pernyataan yang paling mewakili kondisi yang Anda rasakan.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: black,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Image.asset(
              'assets/imgs/tutor_1.png',
              width: 300,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    }

    Widget bagian2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bagian 2',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Anda diminta untuk memberikan skor dengan skala dari ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: black,
                      ),
                ),
                TextSpan(
                  text: '0 - 100',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
                TextSpan(
                  text:
                      ' untuk masing-masing pernyataan. Tuliskan skor sesuai dengan yang Anda rasakan.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: black,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '0',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      ': Sangat Rendah',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: black,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '100',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      ': Sangat Tinggi',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: black,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Image.asset(
              'assets/imgs/tutor_2.png',
              width: 300,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      );
    }

    Widget nextButton() {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 48),
            ),
            backgroundColor: MaterialStateProperty.all(
              primary_500,
            ),
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/quiz-page', (route) => false);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selanjutnya',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_rounded,
                color: black,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: white,
      appBar: appBar(),
      body: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
        ),
        child: ListView(
          children: [
            bagian1(),
            bagian2(),
            nextButton(),
          ],
        ),
      ),
    );
  }
}
