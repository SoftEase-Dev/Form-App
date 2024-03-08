import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/themes/theme.dart';

class OptionItem extends StatefulWidget {
  final String idOption;
  final String conditionState;
  final String option;
  final String question;
  final String image;

  const OptionItem({
    Key? key,
    required this.idOption,
    required this.conditionState,
    required this.option,
    required this.question,
    required this.image,
  }) : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  bool isSelected = false;

  @override
  void didUpdateWidget(covariant OptionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(widget.conditionState);
    if (widget.idOption == widget.conditionState) {
      setState(() {
        isSelected = true;
      });
    } else {
      setState(() {
        isSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      height: 96,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? null : neutral_50,
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0, .6],
                colors: [Color(0xFFEF8633), Color(0xFFEEC049)],
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.transparent : neutral_200,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            isSelected ? 'assets/svgs/selected_option.svg' : widget.option,
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(widget.question,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: isSelected ? white : black)),
          ),
          const SizedBox(
            width: 12,
          ),
          Container(
            width: 98,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(
                  widget.image,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
