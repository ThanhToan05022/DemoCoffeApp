import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/apiservices.dart';
import '../../model/DetailsProducts.dart';
import '../../model/Products.dart';

class HomeController extends GetxController {
  RxString selectedCategory = "All".obs;
  Rx<Products> products = Products().obs;
  RxList<Datum> itemProducts = <Datum>[].obs;
  Rx<ProductDetails> productDetails = ProductDetails().obs;
  var currentSized;
  TextEditingController searchController = TextEditingController();
  Future<List<Datum>>? _searchProducts;
  String searchQuery = "";
  final listDatumSearch = <Datum>[];
  RxBool isSelected = false.obs;

  void toggleSelected() {
    isSelected.value = !isSelected.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllProducts();
    fetchProducts();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void onSelectCategory(String name) {
    selectedCategory.value = name;
    fetchProducts();
  }

  void fetchProducts() {
    if (selectedCategory.value == "All") {
      getAllProducts();
    } else {
      getProductsByCategoryId(selectedCategory.value);
    }
  }

  Future<List<Datum>> searchProducts(String query) async {
    try {
      final response = await ApiServices.get(
        path: "/findProducts/search",
        query: {'Name': query},
      );
      print("API Response: $response");
      List<dynamic> dataList = response['data'] ?? [];
      itemProducts.value = dataList.map((e) => Datum.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return [];
  }

  Future<List<Datum>> getAllProducts() async {
    try {
      final response = await ApiServices.get(path: '/getProducts');
      List<dynamic> dataList = response['data'] ?? [];
      itemProducts.value = dataList.map((e) => Datum.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return [];
  }

  Future<List<Datum>> getProductsByCategoryId(String categoryName) async {
    try {
      final response = await ApiServices.get(
        path: '/getProductsByCategory/$categoryName',
      );
      List<dynamic> dataList = response['data'] ?? [];
      itemProducts.value = dataList.map((e) => Datum.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        print("API lỗi: ${e.response?.data}");
      } else {
        print("Lỗi mạng: ${e.message}");
      }
    }
    return [];
  }

  Future<Data?> getDetailsProducts(String id) async {
    try {
      final response = await ApiServices.get(path: "/getdetailsProducts/$id");
      productDetails.value = ProductDetails.fromJson(response);
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
