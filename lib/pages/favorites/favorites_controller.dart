import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:projectflutter2/api/apiservices.dart';
import 'package:projectflutter2/model/Favorites.dart';

class FavoritesController extends GetxController {
  RxList<Datum> datum = <Datum>[].obs;
  RxBool isSelected = false.obs;

  void toggleSelected() {
    isSelected.value = !isSelected.value;
  }

  @override
  void onInit() async {
    super.onInit();
    await getFavorites();
  }

  // Future<void> deletefavorites(String productId) async {
  //   await deleteFavorites(productId);
  //   // favorites.removeWhere((e) => e.products?.id == productId);
  // }

  Future<List<Datum?>> createFavorites({required String products}) async {
    try {
      final response = await ApiServices.post(
        path: '/createfavorite',
        body: {'products': products},
      );
      List<dynamic> dataList = response['data'] ?? [];
      datum.value = dataList.map((e) => Datum.fromJson(e)).toList();
      await getFavorites();
      datum.refresh();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return [];
  }

  Future<List<Datum?>> getFavorites() async {
    try {
      final response = await ApiServices.get(path: 'getFavorites');
      List<dynamic> dataList = response['data'] ?? [];
      datum.value = dataList.map((e) => Datum.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return [];
  }

  Future<List<Datum?>> deleteFavorites(String id) async {
    try {
      final response = await ApiServices.delete(path: 'deleteFavorite/${id}');
      List<dynamic> dataList = response['data'] ?? [];
      datum.value = dataList.map((e) => Datum.fromJson(e)).toList();
      await getFavorites();
      datum.refresh();
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
