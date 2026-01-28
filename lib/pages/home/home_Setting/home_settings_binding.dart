import 'package:get/get.dart';
import 'package:projectflutter2/pages/home/home_Setting/home_settings_controller.dart';

class HomeSettingsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeSettingsController>(() => HomeSettingsController());

  }

}