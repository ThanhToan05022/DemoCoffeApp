import 'dart:io';

import 'package:flutter/material.dart';

class Myimageprofile extends StatefulWidget {
  final void Function()? onTap;
  final String? imagePath;
  const Myimageprofile({super.key, this.onTap,this.imagePath});

  @override
  State<Myimageprofile> createState() => _MyimageprofileState();
}

class _MyimageprofileState extends State<Myimageprofile> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: widget.imagePath != null && widget.imagePath!.isNotEmpty
            ? Image.file( 
          File(widget.imagePath!),
          width: 153,
          height: 153,
          fit: BoxFit.cover,
        )
            : Image.asset( 
          'image/avatar.png',
          width: 153,
          height: 153,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
