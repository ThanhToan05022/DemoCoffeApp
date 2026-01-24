import 'package:get/get.dart';
import 'package:projectflutter2/pages/order/order_controller.dart';
import 'package:projectflutter2/pages/order/view/payment_controller.dart';


class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => PaymentController());

  }
}
