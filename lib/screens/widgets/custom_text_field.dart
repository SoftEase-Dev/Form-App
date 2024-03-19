import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/themes/theme.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final TextInputFormatter? textInputFormatter;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputFormatter,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            focusNode: _focusNode,
            cursorColor: Colors.grey,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.textInputFormatter != null
                ? [widget.textInputFormatter!]
                : null,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(
              hintText: widget.hint,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              filled: true,
              fillColor: _isFocused ? primary_25 : neutral_50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: neutral_300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: primary_500,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
