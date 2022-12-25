import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final ThemeData theme;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator? validator;
  final String labelText;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;

  const AuthTextField({
    Key? key,
    required this.controller,
    required this.theme,
    required this.labelText,
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
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        label: Text(
          labelText,
          style: theme.textTheme.caption!
              .copyWith(fontSize: 12, color: theme.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.errorColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.errorColor,
          ),
        ),
      ),
    );
  }
}
