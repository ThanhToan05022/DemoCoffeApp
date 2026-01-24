import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectflutter2/components/myTextButton.dart';
import 'package:projectflutter2/components/myloginButton.dart';
import 'package:projectflutter2/components/myloginGoogle.dart';
import 'package:projectflutter2/components/mytextfield.dart';
import 'package:projectflutter2/pages/login/login_pages.dart';
import 'package:projectflutter2/pages/register/register_controller.dart';
import 'package:projectflutter2/theme/Theme.dart';
import 'package:projectflutter2/theme/validate.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _FromKey = GlobalKey<FormState>();
  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _FromKey,
            child: Column(
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 117, right: 116),
                  child: Image.asset("image/Logo.png"),
                ),

                SizedBox(height: 10),

                Text(
                  "Welcome to Lungo !!",
                  style: TextStyle(
                    color: White,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),

                Text(
                  "Register to Continue",
                  style: TextStyle(
                    color: TextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Mytextfield(
                  readOnly: false,
                  controller: registerController.nameController,
                  text: "Name",
                  Obscuretext: false,
                  validate: NameValidator.validate,
                ),
                SizedBox(height: 16),
                Mytextfield(
                  readOnly: false,
                  controller: registerController.emailController,
                  text: "Email Address",
                  Obscuretext: false,
                  validate: EmailValidator.validate,
                ),
                SizedBox(height: 16),
                Mytextfield(
                  readOnly: false,
                  controller: registerController.passwordController,
                  text: "Password",
                  Obscuretext: true,
                  validate: PasswordValidator.validate,
                ),
                SizedBox(height: 16),

                SizedBox(height: 41),
                Myloginbutton(
                  onpress: () async {
                    if (_FromKey.currentState!.validate()) {
                      final result = await registerController.register(
                        registerController.nameController.text,
                        registerController.emailController.text,
                        registerController.passwordController.text,
                      );
                      print("Đăng ký thành công");
                      if (result != null) {
                        print("Đăng ký thành công");
                        Get.back();
                      } else {
                        print("Đăng ký thất bại");
                      }
                    }
                  },
                  text: "Register",
                ),
                SizedBox(height: 25),
                // Mylogingoogle(onpress: () {}, text: "Sign with Google"),
                Mytextbutton(
                  text: "You have an account? Click ",
                  onpress: () {
                    Get.back();
                  },
                  text2: "Sign in",
                ),

                // SizedBox(height: 31),

                // Mytextbutton(
                //   text: "Dont have account? Click ",
                //   onpress: () {},
                //   text2: "Register",
                // ),
                // SizedBox(height: 16),
                // Mytextbutton(
                //   text: "Forget Password? Click ",
                //   onpress: () {},
                //   text2: "Reset",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
