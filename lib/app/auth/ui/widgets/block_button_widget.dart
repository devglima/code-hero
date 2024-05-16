import 'package:flutter/material.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {Key? key,
      required this.color,
      required this.text,
      required this.loading,
      required this.onPressed})
      : super(key: key);

  final Color color;
  final Text text;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: this.color.withOpacity(0.4),
              blurRadius: 40,
              offset: const Offset(0, 15)),
          BoxShadow(
              color: this.color.withOpacity(0.4),
              blurRadius: 13,
              offset: const Offset(0, 3))
        ],
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: ElevatedButton(
        onPressed: this.onPressed,
        style: flatButtonStyle(color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            this.text,
            if (loading) ...[
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.white,
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}

flatButtonStyle(Color color) {
  return TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    backgroundColor: color,
    shape: const StadiumBorder(),
  );
}
