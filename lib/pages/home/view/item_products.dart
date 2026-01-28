import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:projectflutter2/pages/home/home_controller.dart';
import 'package:projectflutter2/pages/order/order_controller.dart';
import 'package:projectflutter2/theme/NumbercurrentFormat.dart';
import 'package:projectflutter2/theme/Theme.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ItemProducts extends StatefulWidget {
  final void Function(String id)? onTap;
  final String selectedCategory;
  final void Function()? onPressed;

  ItemProducts({
    super.key,
    this.selectedCategory = "Coffee beans",
    this.onTap,
    this.onPressed,
  });

  @override
  State<ItemProducts> createState() => _ItemProductsState();
}

class _ItemProductsState extends State<ItemProducts> {
  final homeController = Get.find<HomeController>();
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = homeController.itemProducts;
      if (products.isEmpty) {
        return const Center(child: Text('No products found.'));
      }
      return GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: false,
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final datum = products[index];
          print("Image URL: ${datum.imageUrl}");
          return buildItemProducts(
            id: datum.id ?? "",
            name: datum.name ?? '',
            price: datum.price?.toInt() ?? 0,
            imageUrl: datum.imageUrl ?? '',
            rating: datum.rating ?? '0',
            description: datum.description ?? '',
          );
        },
      );
    });
  }

  Widget buildItemProducts({
    required String id,
    required String name,
    required int price,
    required String imageUrl,
    required String description,
    required String rating,
  }) {
    return Container(
      margin: EdgeInsets.zero,
      width: double.infinity,
      decoration: BoxDecoration(
        color: outputBorder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onTap?.call(id);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 15),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: White,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  description,
                  style: const TextStyle(color: White, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Numbercurrentformat(price),
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, size: 12),
                        color: White,
                        onPressed: () async {
                          try {
                            final result = await orderController.createOrder(
                              productId: id,
                              quantity: 1,
                              price: price,
                              size: "",
                            );
                            print(result);
                            Get.snackbar(
                              'Success',
                              'Added to cart successfully',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          } on Exception catch (e) {
                            print(e);
                            Get.snackbar(
                              'Error',
                              e.toString(),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
