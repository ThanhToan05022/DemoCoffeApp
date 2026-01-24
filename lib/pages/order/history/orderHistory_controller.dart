import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:projectflutter2/api/apiservices.dart';
import 'package:projectflutter2/model/orderHistory.dart';

class OrderhistoryController extends GetxController {
  RxList<Datum> orderHistory = <Datum>[].obs;
  @override
  void onInit() {
    super.onInit();
    getCheckout();
  }

  Future<void> createCheckout() async {
    try {
      final response = await ApiServices.post(path: '/checkout');
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return null;
  }

  Future<List<Datum?>> getCheckout() async {
    try {
      final response = await ApiServices.get(path: '/invoices');
      List<dynamic> data = response['data'];
      orderHistory.value = data.map((e) => Datum.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return [];
  }
}
