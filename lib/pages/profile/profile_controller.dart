import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../api/apiservices.dart';
import '../../model/User.dart';

class ProfileController extends GetxController {
  Rx<UserProfileModel> profile = UserProfileModel().obs;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  String? pathFile;
  XFile? picked;
  String? imageBase64;

  @override
  void onInit() {

    super.onInit();
    getProfile();
  }

  @override
  void dispose() {

    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  Future<UserProfileModel?> updateProfile(
    String name,
    String password,
    XFile imageFile,
  ) async {
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'name': name,
        'password': password,
        if (imageFile != null)
          'image': await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      });
      final response = await ApiServices.put(path: '/profile', body: formData);
      return profile.value = UserProfileModel.fromJson(response);
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
      return null;
    }
  }

  Future<UserProfileModel?> getProfile() async {
    try {
      final response = await ApiServices.get(path: '/profile');

      return profile.value = UserProfileModel.fromJson(response);
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
      return null;
    }
  }
}
