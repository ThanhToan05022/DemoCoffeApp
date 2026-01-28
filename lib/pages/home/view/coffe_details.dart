import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';


import 'package:projectflutter2/theme/Theme.dart';


import '../../bottom_bar.dart';
import '../../order/order_controller.dart';
import '../home_controller.dart';
import 'package:projectflutter2/pages/favorites/favorites_controller.dart';

class CoffeDetails extends StatefulWidget {
  final void Function(String id)? onPressed;
  final String? productId;

  CoffeDetails({super.key, this.onPressed, this.productId});

  @override
  State<CoffeDetails> createState() => _CoffeDetailsState();
}

class _CoffeDetailsState extends State<CoffeDetails> {
  final homeController = Get.find<HomeController>();
  final orderController = Get.find<OrderController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.productId != null) {
      homeController.getDetailsProducts(widget.productId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = homeController.productDetails.value.data;
      if (products == null) {
        return const Center(child: Text('No products found.'));
      }
      return SizedBox(
        height: 350,
        child: buildItemDetails(
          id: products?.id ?? "",
          imageUrl: products?.imageUrl ?? "",
          description: products?.description ?? "",
          name: products?.name ?? '',
          price: products?.price?.toInt() ?? 0,
          rating: products?.rating ?? "",
          size: products?.size ?? "",

        ),
      );
    });
  }
}

Widget buttonSized({required String text, required bool isSelect}) {
  final homeController = Get.find<HomeController>();
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: search,
    ),
    child: TextButton(
      onPressed: () => homeController.currentSized == isSelect ? null : text,
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 14),
        foregroundColor: isSelect ? radius : Color(0xffaeaeae),
      ),
      child: Text(text, style: TextStyle()),
    ),
  );
}

Widget buildItemDetails({
  required String id,
  required String name,
  required String description,
  required int price,
  required String imageUrl,
  required String rating,
  required String size,
  // required onPressed,
}) {
  final homeController = Get.find<HomeController>();
  final orderController = Get.find<OrderController>();
  final favoritesController = Get.find<FavoritesController>();

  return Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  left: 16,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: radius,
                    ),
                    child: IconButton(
                      onPressed: () => {Get.to(BottomBar())},
                      icon: Icon(Icons.arrow_back, size: 25),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: radius,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        try {
                          final result = await favoritesController
                              .createFavorites(products: id);
                          print(result);
                          await favoritesController.getFavorites();
                          homeController.toggleSelected();
                          Get.snackbar(
                            'Success',
                            'Added to favorites successfully',
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
                      icon: Obx(() {
                        final isSelected = homeController.isSelected.value;
                        return Icon(
                          isSelected ? Icons.favorite : Icons.favorite_border,
                          color: isSelected ? Colors.red : Colors.white,
                        );
                      }),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffAEAEAE),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Icon(Icons.star, color: radius),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  rating,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "(6879)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xffaeaeae),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Wrap(
                                spacing: 4,
                                runSpacing: 6,
                                children: [
                                  buildIcon(Icons.coffee, 'Coffee'),
                                  const SizedBox(width: 8),
                                  buildIcon(Icons.water_drop, 'Milk'),
                                  const SizedBox(width: 8),
                                  buildText('Medium Roasted'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "Description",
                    style: const TextStyle(color: Color(0xffaeaeae)),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "Cappuccino is a latte made with more foam than\nsteamed milk, often with a sprinkle of cocoa powder or\n cinnamon on top.",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 55),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                "Size",
                style: TextStyle(
                  color: Color(0xffaeaeae),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonSized(
                  text: 'S',
                  isSelect: homeController.currentSized == 'S',
                ),
                const SizedBox(height: 25),
                buttonSized(
                  text: 'M',
                  isSelect: homeController.currentSized == 'M',
                ),
                const SizedBox(height: 25),
                buttonSized(
                  text: 'L',
                  isSelect: homeController.currentSized == 'L',
                ),
              ],
            ),
            SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: Text(
                "Price",
                style: TextStyle(
                  color: Color(0xffaeaeae),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: Text(
                    '${price.toString()} \đ',
                    style: TextStyle(
                      color: White,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: radius,
                  ),
                  child: ElevatedButton(
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
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildIcon(IconData icon, String name) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: Color(0xff141921),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Icon(icon, color: Colors.orange, size: 18),
        const SizedBox(height: 2),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    ),
  );
}

Widget buildText(String name) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: Color(0xff141921),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    ),
  );
}
