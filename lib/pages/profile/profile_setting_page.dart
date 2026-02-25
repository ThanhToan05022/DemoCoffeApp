import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectflutter2/pages/profile/compoment/myImageProfile.dart';
import 'package:projectflutter2/components/mybackButton.dart';
import 'package:projectflutter2/components/myloginButton.dart';
import 'package:projectflutter2/components/mytextfield.dart';
import 'package:projectflutter2/pages/profile/profile_controller.dart';
import 'package:projectflutter2/theme/Theme.dart';
import 'package:projectflutter2/theme/validate.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Mybackbutton(onPressed: () => Get.back()),
                Padding(
                  padding: const EdgeInsets.only(left: 130.0),
                  child: Text(
                    'Setting',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: White,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 41),
            Myimageprofile(
              onTap: pickImage,
              imagePath: profileController.pathFile,
            ),
            SizedBox(height: 73),
            Mytextfield(
              readOnly: false,
              text: 'Name ',
              Obscuretext: false,
              controller: profileController.nameController,
              validate: NameValidator.validate,
            ),
            SizedBox(height: 16),

            Mytextfield(
              text: 'Password',
              Obscuretext: true,
              readOnly: false,
              controller: profileController.passwordController,
              validate: PasswordValidator.validate,
            ),
            SizedBox(height: 20),

            Myloginbutton(
              onpress: () async {
                try {
                  await profileController.updateProfile(
                    profileController.nameController.text,
                    profileController.passwordController.text,
                    profileController.picked!,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cập nhật hồ sơ thành công!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi khi cập nhật: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      profileController.picked = image;
      profileController.pathFile = image.path;
    });
  }

  Widget imageAvatar() {
    return Center(
      child: GestureDetector(
        onTap: pickImage,
        child: ClipOval(
          child: profileController.pathFile != null
              ? Image.network(
                  (profileController.pathFile!),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'image/avatar.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
