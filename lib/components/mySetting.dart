import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';

class Mysetting extends StatelessWidget {
  const Mysetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0XFF21262E),
      ),
      child: Icon(Icons.grid_view_outlined, color: Colors.white, size: 14),
    );
  }
}
