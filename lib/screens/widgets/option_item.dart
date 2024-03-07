import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/themes/theme.dart';

class OptionItem extends StatefulWidget {
  final String option;
  final String question;
  final String image;

  const OptionItem({
    Key? key,
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        height: 96,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? primary_500 : neutral_50,
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
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(widget.question,
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            SizedBox(
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
      ),
    );
  }
}
