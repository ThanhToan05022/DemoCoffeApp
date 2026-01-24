import 'package:get/get.dart';
import 'package:projectflutter2/pages/favorites/favorites_controller.dart';

class FavoritesBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => FavoritesController());
  }
}