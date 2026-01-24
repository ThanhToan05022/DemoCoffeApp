import 'package:flutter/material.dart';
import 'package:projectflutter2/theme/Theme.dart';

class myFavorite extends StatelessWidget {
  void Function()? onPressed;

  myFavorite({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff21262E),
        border: Border.all(width: 1, color: Color(0xff21262E)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.favorite),
      ),
    );
  }
}
