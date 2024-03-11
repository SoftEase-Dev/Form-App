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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0, 1],
                        colors: [Color(0XFFEF8633), Color(0XFFEEC049)]),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(90),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}
