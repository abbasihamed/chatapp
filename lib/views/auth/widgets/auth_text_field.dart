import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  // final ThemeData theme;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator? validator;
  final String labelText;
  final String? hintText;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;

  const AuthTextField({
    Key? key,
    required this.controller,
    // required this.theme,
    required this.labelText,
    this.hintText,
    this.maxLength,
    this.onSubmitted,
    this.validator,
    this.keyboardType,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      controller: controller,
      autofocus: true,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      keyboardType: keyboardType,
      textAlign: textAlign!,
      cursorColor: const Color(0xFF3B76F6),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }
}
