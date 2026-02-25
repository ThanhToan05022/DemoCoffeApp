import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';

class Mysetting extends StatefulWidget {
  final void Function()? onPressed;

  const Mysetting({super.key, this.onPressed});

  @override
  State<Mysetting> createState() => _MysettingState();
}

class _MysettingState extends State<Mysetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0XFF21262E),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onPressed,
            icon: Icon(Icons.grid_view_outlined),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
