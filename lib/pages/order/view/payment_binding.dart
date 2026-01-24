import 'package:get/get.dart';

import 'package:projectflutter2/pages/order/view/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PaymentController());
  }
}
