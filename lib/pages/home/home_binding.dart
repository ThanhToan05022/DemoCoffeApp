import 'package:get/get.dart';
import 'package:projectflutter2/pages/favorites/favorites_controller.dart';
import 'package:projectflutter2/pages/home/home_Setting/home_settings_controller.dart';
import 'package:projectflutter2/pages/home/home_controller.dart';

import '../profile/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    // Get.lazyPut(() => FavoritesController());
    Get.lazyPut<FavoritesController>(() => FavoritesController());
    Get.lazyPut<HomeSettingsController>(() => HomeSettingsController());
  }
}
