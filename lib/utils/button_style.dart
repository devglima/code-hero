import 'package:flutter/material.dart';

buttonStyleStadium(BuildContext context) {
  return TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14),
    backgroundColor: Colors.red,
    shape: const StadiumBorder(),
    minimumSize: const Size(230.0, 0),
  );
}
