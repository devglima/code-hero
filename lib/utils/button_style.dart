import 'package:flutter/material.dart';

buttonStyle(BuildContext context) {
  return TextButton.styleFrom(
    textStyle: TextStyle(
      color: Theme.of(context).hintColor,
    ),
  );
}

cartButtonStyle(BuildContext context) {
  return TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14),
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shape: const StadiumBorder(),
  );
}

buttonStyleStadium(BuildContext context) {
  return TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14),
    backgroundColor: Colors.red,
    shape: const StadiumBorder(),
    minimumSize: const Size(230.0, 0),
  );
}

buttonStyleStadiumWithoutOpacity(BuildContext context) {
  return TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14),
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shape: const StadiumBorder(),
  );
}
