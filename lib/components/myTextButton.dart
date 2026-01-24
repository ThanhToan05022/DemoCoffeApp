import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';

class Mytextbutton extends StatelessWidget {
  final String text, text2;
  final VoidCallback onpress;
  const Mytextbutton({
    super.key,
    required this.text,
    required this.onpress,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: TextColor, fontSize: 12),
          text: text,
          children: [
            TextSpan(
              text: text2,
              style: const TextStyle(color: radius, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
