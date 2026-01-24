import 'package:get/get.dart';
import 'package:projectflutter2/pages/order/history/orderHistory_controller.dart';

class OrderhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderhistoryController>(() => OrderhistoryController());
  }
}
