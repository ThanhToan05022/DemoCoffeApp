import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';

class Mybackbutton extends StatelessWidget {
  void Function()? onPressed;

  Mybackbutton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 30,
      // height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: <Color>[Color(0xff21262E), Color(0xff0C0F14)],
        ),
        border: BoxBorder.all(
          color: Color(0xff21262E),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
      ),
    );
  }
}
