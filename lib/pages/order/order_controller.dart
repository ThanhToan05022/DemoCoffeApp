import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../api/apiservices.dart';
import '../../model/Order.dart';

class OrderController extends GetxController {
  Rx<Cart> cart = Cart().obs;
  RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getOneOrders();
  }

  void increasePrice(Item item) {
    item.quantity = (item.quantity ?? 0) + 1;
    calculateTotalPrice();
    cart.refresh();
  }

  void decreasePrice(Item item) async {
    final current = item.quantity ?? 0;
    if (current > 1) {
      item.quantity = current - 1;
    } else {
      final id = item.id;
      if (id != null) {
        await deleteOrders(id);
      }
    }
    calculateTotalPrice();
    cart.refresh();
  }

  void calculateTotalPrice() {
    int total = 0;
    for (var item in cart.value.items!) {
      total += ((item.products?.price ?? 0) * (item.quantity ?? 0)).toInt();
    }
    cart.value.totalPrice = total;
  }

  Future<Cart?> createOrder({
    required String productId,
    required int quantity,
    required int price,
    required String size,
  }) async {
    try {
      final response = await ApiServices.post(
        path: '/createCart',
        body: {
          'productId': productId,
          'quantity': quantity,
          'price': price,
          'size': size,
        },
      );
      cart.value = Cart.fromJson(response['data']);
      calculateTotalPrice();
      cart.refresh();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return null;
  }

  Future<Cart?> getOneOrders() async {
    try {
      final response = await ApiServices.get(path: '/getCart');
      cart.value = Cart.fromJson(response['data']);
      // calculateTotalPrice();
      cart.refresh();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return null;
  }

  Future<Cart?> deleteOrders(String id) async {
    try {
      final response = await ApiServices.delete(
        path: '/deleteOrders/item/${id}',
      );
      print(response);
      cart.value.items?.removeWhere((e) => e.id == id);
      cart.value.totalPrice = response['data']['totalPrice'];
      cart.refresh();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return null;
  }
}
