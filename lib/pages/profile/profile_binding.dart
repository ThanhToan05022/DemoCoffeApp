import 'package:get/get.dart';
import 'package:projectflutter2/pages/profile/profile_controller.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ProfileController());
  }
}
