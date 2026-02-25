import 'package:flutter/material.dart';

class Myhomesetting extends StatelessWidget {
  final String? name;
  final Widget icon;
  final void Function()? onPressed;

  const Myhomesetting({super.key, this.onPressed, required this.icon, this.name});

  @override
  Widget build(BuildContext context) {
    return  Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: onPressed, icon: icon),
          Padding(
            padding: const EdgeInsets.only(left: 55.0),
            child: Text(
              name!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  }
}
