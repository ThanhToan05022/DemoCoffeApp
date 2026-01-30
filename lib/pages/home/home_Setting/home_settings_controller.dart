import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/apiservices.dart';
import '../../../routes/app_routes.dart';

class HomeSettingsController extends GetxController {

  Future<void> showLogoutDialog() async {
    Get.defaultDialog(
      title: 'Confirm logout',
      backgroundColor: Colors.blueAccent,
      middleText: 'Are you sure you want to log out?',
      textCancel: 'Cancel',
      textConfirm: 'Logout',
      onConfirm: () async {
        Get.back();
        await _performLogout();
      },
    );
  }

  Future<void> _performLogout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await ApiServices.post(path: '/logout');
      final success = response['success'] == true;
      final message = response['message'] ?? 'Logged out';

      // Clear local session
      await prefs.remove('token');
      await prefs.remove('email');
      await prefs.remove('password');
      // await prefs.setBool('remember_me', false);

      Get.snackbar(success ? 'Success' : 'Info', message, snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(AppRoutes.login);
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return null;
  }
}
