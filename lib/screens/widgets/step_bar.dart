import 'package:flutter/material.dart';
import 'package:form_app/themes/theme.dart';

class StepBar extends StatefulWidget {
  final int stepNumber;
  final int questionsCount;

  const StepBar(
      {super.key, required this.stepNumber, required this.questionsCount});

  @override
  State<StepBar> createState() => _StepBarState();
}

class _StepBarState extends State<StepBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            "${widget.stepNumber}/${widget.questionsCount}",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w900, color: white),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(90),
                ),
              ),
              child: FractionallySizedBox(
                widthFactor: widget.stepNumber / widget.questionsCount,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0, 1],
                        colors: [Color(0XFFEF8633), Color(0XFFEEC049)]),
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showCancelConfirmationDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(90),
                ),
              ),
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Batalkan Pengisian?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          content: Text(
            'Apakah Anda yakin ingin membatalkan pengisian formulir NASA TLX? Tindakan ini akan menghapus semua data yang telah Anda masukkan.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 48),
                ),
                backgroundColor: MaterialStateProperty.all(neutral_200),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Lanjut Isi',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: neutral_900, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 48),
                ),
                backgroundColor: MaterialStateProperty.all(primary_500),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Text(
                'Konfirmasi',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: neutral_900, fontWeight: FontWeight.w900),
              ),
            )
          ],
        );
      },
    );
  }
}
