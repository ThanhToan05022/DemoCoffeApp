import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectflutter2/routes/app_routes.dart';
import 'package:projectflutter2/api/notification_services.dart';
import 'package:projectflutter2/theme/Theme.dart';
import 'package:projectflutter2/theme/theme_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await NotificationServices().init();


  await Get.putAsync<ThemeService>(() async => await ThemeService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode = ThemeService.to.theme;
      return GetMaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        getPages: AppRoutes.routes,
      );
    });
  }
}
