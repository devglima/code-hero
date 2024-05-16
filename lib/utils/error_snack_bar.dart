import 'package:flutter/material.dart';

abstract class SnackBarColors {
  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
}

showSnackBarError(BuildContext context, String message, Color color,
    {double? marginBottom}) {
  final snackBar = SnackBar(
    elevation: 0,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: marginBottom ?? 30.0, left: 30, right: 30),
    backgroundColor: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    content: Container(
      padding: const EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
