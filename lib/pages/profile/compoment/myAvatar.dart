import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:projectflutter2/pages/profile/profile_controller.dart';

class Myavatar extends StatefulWidget {
  final void Function()? onTap;

  Myavatar({super.key, this.onTap});

  @override
  State<Myavatar> createState() => _MyavatarState();
}

class _MyavatarState extends State<Myavatar> {
  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return InkWell(
      onTap: widget.onTap,
      child: Obx(() {
        return ClipRRect(
          borderRadius: BorderRadius.circular(75),
          child: Image.network(
            profileController.profile.value.profile?.avatar ??
                "https://jytjhgjh.s3.ap-southeast-2.amazonaws.com/uploads/",
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        );
      }),
    );
  }
}
