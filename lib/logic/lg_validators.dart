import 'package:email_validator/email_validator.dart';

String? emailValidator(String? s) {
  if (s != null) {
    if (EmailValidator.validate(s)) {
      return null;
    } else {
      return "";
    }
  } else {
    return "";
  }
}

String? passwordValidator(String? s) {
  if (s != null) {
    if (s.length >= 6) {
      return null;
    } else {
      return "";
    }
  } else {
    return "";
  }
}

String? notEmptyValidator(String? s, {int minLen = 1}) {
  if (s != null) {
    if (s.length >= minLen && s.isNotEmpty) {
      return null;
    } else {
      return "";
    }
  } else {
    return "";
  }
}

String? dateValidator(String? s) {
  if (s != null) {
    if (s.isNotEmpty &&
        RegExp(r'[0-9]{2}.[0-9]{2}.[0-9]{4}$').hasMatch(s) &&
        s.length == 10) {
      return null;
    } else {
      return "";
    }
  } else {
    return "";
  }
}
