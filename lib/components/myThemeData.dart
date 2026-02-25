import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectflutter2/theme/theme_service.dart';

class myThemeData extends StatefulWidget {
  const myThemeData({super.key});

  @override
  State<myThemeData> createState() => _myThemeDataState();
}

class _myThemeDataState extends State<myThemeData> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = ThemeService.to.theme == ThemeMode.dark;
      return IconButton(
        onPressed: () => ThemeService.to.toggleTheme(),
        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      );
    });
  }
}
