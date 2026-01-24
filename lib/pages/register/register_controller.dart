import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../api/apiservices.dart';
import '../../model/User.dart';
class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  Future<UserProfileModel?> register(String name, String email, String password) async {
    try {
      Map<String,dynamic> response = await ApiServices.post(
        path: '/register',
        body: {'name': name, 'email': email, 'password': password},
      );
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