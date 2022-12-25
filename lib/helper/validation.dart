import '../core/constanst.dart';

class InputValidation {
  static InputValidation inputValidation = InputValidation();

  emptyValidation(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Code can not be empty';
      }
      return null;
    }
    return null;
  }

  emailValidation(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Input is empty';
      }
      if (!RegExp(emailRegex).hasMatch(value)) {
        return 'Not valid email';
      }
    }
    return null;
  }
}
