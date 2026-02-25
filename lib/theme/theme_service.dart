import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  static const _key = 'isDarkMode';
  final Rx<ThemeMode> _themeMode = ThemeMode.dark.obs;

  ThemeMode get theme => _themeMode.value;
  Rx<ThemeMode> get themeMode => _themeMode;

  static ThemeService get to => Get.find<ThemeService>();

  Future<ThemeService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? true;
    _themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;

    Get.changeThemeMode(_themeMode.value);
    return this;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (_themeMode.value == ThemeMode.dark) {
      _themeMode.value = ThemeMode.light;
      await prefs.setBool(_key, false);
      Get.changeThemeMode(ThemeMode.light);
    } else {
      _themeMode.value = ThemeMode.dark;
      await prefs.setBool(_key, true);
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode.value = mode;
    await prefs.setBool(_key, mode == ThemeMode.dark);
    Get.changeThemeMode(mode);
  }
}

