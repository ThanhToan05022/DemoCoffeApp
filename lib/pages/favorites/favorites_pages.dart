import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:projectflutter2/components/myFavorite.dart';
import 'package:projectflutter2/components/mySetting.dart';
import 'package:projectflutter2/model/Favorites.dart';
import 'package:projectflutter2/pages/favorites/favorites_controller.dart';
import 'package:projectflutter2/pages/profile/compoment/myAvatar.dart';

class FavoritesPages extends StatefulWidget {
  FavoritesPages({super.key});

  @override
  State<FavoritesPages> createState() => _FavoritesPagesState();
}

class _FavoritesPagesState extends State<FavoritesPages> {
  final favoritesController = Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    final items = favoritesController.datum;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Mysetting(),
                Text(
                  'Favorites',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Myavatar(),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    // print("Image URL: ${data.products?.imageUrl}");
                    return buildItemFavorites(products: item);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemFavorites({required Datum products}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: products.products?.imageUrl ?? "",
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () async {
                      try {
                        final result = await favoritesController
                            .deleteFavorites(products.products?.id ?? "");
                        print(result);
                        Get.snackbar(
                          'Success',
                          'Removed from favorites',
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
                    icon: Icon(Icons.favorite, color: Colors.red),
                  ),
                  top: 10,
                  right: 10,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    height: 130,
                    decoration: BoxDecoration(
                      color: Color(0xff000000),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 3),
                        Text(
                          products.products?.name ?? "",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          products.products?.description ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffaeaeae),
                          ),
                        ),
                        SizedBox(height: 3),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.deepOrange),
                                  SizedBox(width: 6),
                                  Text(
                                    products.products?.rating ?? "",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "(6,879)",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffaeaeae),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                flex: 3,
                                child: Wrap(
                                  spacing: 2,
                                  runSpacing: 2,
                                  children: [
                                    buildIcon(Icons.coffee, 'Coffee'),
                                    const SizedBox(width: 8),
                                    buildIcon(Icons.water_drop, 'Milk'),
                                    const SizedBox(width: 8),
                                    buildText('Medium Roasted'),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: <Color>[Color(0xff262B33), Color(0xff262B33)],
          //     ),
          //   ),
          //   child: Text(
          //     'Description',
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400,
          //       color: Color(0xffaeaeae),
          //     ),
          //   ),
          // ),
          // Text(
          //   'Cappuccino is a latte made with more foam than\n steamed milk, often with a sprinkle of cocoa\n powder or cinnamon on top.',
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontWeight: FontWeight.w400,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildIcon(IconData icon, String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xff141921),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange, size: 18),
          const SizedBox(height: 2),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildText(String name) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.7, horizontal: 16),
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
}
