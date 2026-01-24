import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';


class Myloginbutton extends StatefulWidget {
  final VoidCallback onpress;
  final String text;

  const Myloginbutton({super.key, required this.onpress, required this.text});

  @override
  State<Myloginbutton> createState() => _MyloginbuttonState();
}

class _MyloginbuttonState extends State<Myloginbutton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 348,
      // height: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: radius,
      ),
      child: TextButton(
        onPressed: widget.onpress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: White,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
