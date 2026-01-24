import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';

import '../../api/apiservices.dart';
import '../../data/shared_preferences.dart';
import '../../model/User.dart';

class LoginController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool rememberMe = false.obs;

  @override
  void onInit() {
    _loadRememberMe();
    super.onInit();
  }

  Future<void> _loadRememberMe() async {
    final pref = await SharedPreferences.getInstance();
    rememberMe.value = pref.getBool('remember_me') ?? false;
    if (rememberMe.value) {
      emailController.text = pref.getString('email') ?? '';
      passwordController.text = pref.getString('password') ?? '';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<UserProfileModel?> Login(String email, String password) async {
    try {
      Map<String, dynamic> response = await ApiServices.post(
        path: '/login',
        body: {'email': email, 'password': password},
      );
      final token = response["token"].toString();
      await saveToken(token);
      return UserProfileModel.fromJson(response);
    } on DioException catch (e) {
      if (e.response != null) {
        print("❌ API lỗi: ${e.response?.data}");
      } else {
        print("❌ Lỗi mạng: ${e.message}");
      }
      return null;
    }
  }
}
