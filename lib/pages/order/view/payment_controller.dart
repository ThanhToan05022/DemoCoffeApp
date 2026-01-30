import 'package:get/get.dart';
import 'package:projectflutter2/api/notification_services.dart';

class PaymentController extends GetxController {
  final RxnString selectedPayment = RxnString();

  void selectPayment(String? name) {
    selectedPayment.value = name;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    NotificationServices();
    NotificationServices().init();
  }
}
