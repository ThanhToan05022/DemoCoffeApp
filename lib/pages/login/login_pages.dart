import 'package:flutter/material.dart';
import 'package:projectflutter2/components/myTextButton.dart';
import 'package:projectflutter2/components/myloginButton.dart';
import 'package:projectflutter2/components/myloginGoogle.dart';
import 'package:projectflutter2/components/mytextfield.dart';
import 'package:projectflutter2/pages/login/login_controller.dart';
import 'package:projectflutter2/routes/app_routes.dart';
import 'package:projectflutter2/theme/Theme.dart';
import 'package:projectflutter2/theme/validate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  "Login to Continue",
                  style: TextStyle(
                    color: TextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Mytextfield(
                  readOnly: false,
                  controller: loginController.emailController,
                  text: "Email Address",
                  Obscuretext: false,
                  validate: EmailValidator.validate,
                ),
                SizedBox(height: 16),
                Mytextfield(
                  readOnly: false,
                  controller: loginController.passwordController,
                  text: "Password",
                  Obscuretext: true,
                  validate: PasswordValidator.validate,
                ),
                SizedBox(height: 10),
                Obx(
                  () => CheckboxListTile(
                    value: loginController.rememberMe.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        loginController.rememberMe.value = value;
                      }
                    },
                    activeColor: Colors.blue,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      "Remember Me",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 41),
                Myloginbutton(
                  onpress: () async {
                    final result = await loginController.Login(
                      loginController.emailController.text,
                      loginController.passwordController.text,
                    );
                    if (result != null) {
                      final pref = await SharedPreferences.getInstance();
                      if (loginController.rememberMe.value) {
                        await pref.setBool("remember_me", true);
                        await pref.setString(
                          "email",
                          loginController.emailController.text,
                        );
                        await pref.setString(
                          "password",
                          loginController.passwordController.text,
                        );
                      }
                      print('Login successfully!');
                      Get.toNamed(AppRoutes.bottomBar);
                    } else {
                      print('Login failed! Please try again!');
                    }
                  },
                  text: "Sign in",
                ),
                SizedBox(height: 25),
                Mylogingoogle(onpress: () {}, text: "Sign with Google"),

                SizedBox(height: 31),

                Mytextbutton(
                  text: "Dont have account? Click ",
                  onpress: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  text2: "Register",
                ),
                SizedBox(height: 16),
                Mytextbutton(
                  text: "Forget Password? Click ",
                  onpress: () {},
                  text2: "Reset",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
