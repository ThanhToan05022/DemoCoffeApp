import 'package:flutter/material.dart';

class Myhomesetting extends StatelessWidget {
  String? name;
  Widget icon;
  void Function()? onPressed;

  Myhomesetting({super.key, this.onPressed, required this.icon, this.name});

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
