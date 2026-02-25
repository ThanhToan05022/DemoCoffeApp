import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectflutter2/routes/app_routes.dart';
import 'package:projectflutter2/api/notification_services.dart';
import 'package:projectflutter2/components/myThemeData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await NotificationServices().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode:ThemeMode.dark ,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
