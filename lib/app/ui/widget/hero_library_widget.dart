import 'package:flutter/material.dart';

class HeroLibraryWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final int quantity;

  const HeroLibraryWidget({
    super.key,
    required this.title,
    required this.quantity,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const Spacer(),
        Text(
          quantity.toString(),
          style: const TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }
}
