String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
      return 'Should contain at least one upper case';
    } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
      return 'Should contain at least one number';
    } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
      return 'At least one special character';
    } else if (!RegExp(r'^.{8,}').hasMatch(value)) {
      return 'Must be at least 8 characters in length';
    } else {
      return null;
    }
  }
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}
