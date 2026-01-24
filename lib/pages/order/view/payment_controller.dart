import 'package:get/get.dart';

class PaymentController extends GetxController {
  final RxnString selectedPayment = RxnString();

  void selectPayment(String? name) {
    selectedPayment.value = name;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
