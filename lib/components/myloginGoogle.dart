import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';

class Mylogingoogle extends StatelessWidget {
  final VoidCallback onpress;
  final String text;

  const Mylogingoogle({super.key, required this.onpress, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 348,
      // height: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: White,
      ),
      child: TextButton(
        onPressed: onpress,
        child: Stack(
          children: [
            Image.asset("image/google.png"),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
