import 'package:flutter/material.dart';
import 'package:get/get.dart';

class myThemeData extends StatefulWidget {
  const myThemeData({super.key});

  @override
  State<myThemeData> createState() => _myThemeDataState();
}

class _myThemeDataState extends State<myThemeData> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.changeThemeMode(
        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
      ),
      icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
