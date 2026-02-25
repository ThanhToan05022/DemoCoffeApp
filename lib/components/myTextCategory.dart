import 'package:flutter/material.dart';

import 'package:projectflutter2/theme/Theme.dart';

class Mytextcategory extends StatefulWidget {
  final String text;
  final bool isSelected;
  final void Function()? onPressed;

  const Mytextcategory({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<Mytextcategory> createState() => _MytextcategoryState();
}

class _MytextcategoryState extends State<Mytextcategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: widget.onPressed,
          child: Column(
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.isSelected ? Colors.deepOrange : Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? Colors.deepOrange
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
