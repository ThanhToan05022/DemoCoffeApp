import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:projectflutter2/components/myHomeSetting.dart';
import 'package:projectflutter2/components/mybackButton.dart';
import 'package:projectflutter2/pages/home/home_Setting/home_settings_controller.dart';

class HomeSettingsPages extends StatefulWidget {
  HomeSettingsPages({super.key});

  @override
  State<HomeSettingsPages> createState() => _HomeSettingsPagesState();
}

class _HomeSettingsPagesState extends State<HomeSettingsPages> {
  final homeSettingController = Get.find<HomeSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Mybackbutton(onPressed: () => Get.back()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 125.0),
                    child: Text(
                      'Setting',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Myhomesetting(
                icon: Image.asset('image/clock.png', fit: BoxFit.cover),
                name: 'History',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Myhomesetting(
                icon: Image.asset('image/person.png', fit: BoxFit.cover),
                name: 'Personal Details',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Myhomesetting(
                icon: Image.asset('image/location.png', fit: BoxFit.cover),
                name: 'Address',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Myhomesetting(
                icon: Image.asset('image/payment.png', fit: BoxFit.cover),
                name: 'Payment method',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Myhomesetting(
                icon: Image.asset('image/ABOUT.png', fit: BoxFit.cover),
                name: 'About',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Myhomesetting(
                icon: Image.asset('image/help.png', fit: BoxFit.cover),
                name: 'Help',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Myhomesetting(
                icon: Image.asset('image/out.png', fit: BoxFit.cover),
                name: 'Log out',
                onPressed: () => homeSettingController.showLogoutDialog(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
