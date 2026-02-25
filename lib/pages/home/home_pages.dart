import 'package:flutter/material.dart';
import 'package:projectflutter2/components/mySetting.dart';
import 'package:projectflutter2/components/myThemeData.dart';
import 'package:projectflutter2/pages/home/home_Setting/home_settings_pages.dart';

import 'package:projectflutter2/pages/home/view/BeanDetails.dart';

import 'package:projectflutter2/pages/home/view/coffe_details.dart';
import 'package:projectflutter2/pages/profile/compoment/myAvatar.dart';
import 'package:projectflutter2/pages/home/Compoment/mySearchProducts.dart';
import 'package:projectflutter2/components/myTextCategory.dart';
import 'package:projectflutter2/pages/profile/profile_setting_page.dart';

import '../profile/profile_controller.dart';
import 'view/item_products.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final homeController = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    homeController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Mysetting(onPressed: () => Get.to(HomeSettingsPages())),
                        myThemeData(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Myavatar(
                            onTap: () {
                              Get.to(SettingPage());
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Find the best \ncoffe for you",
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black , fontSize: 28),
                    ),
                    const SizedBox(height: 35),
                    Mysearchproducts(),
                    const SizedBox(height: 40),
                    Obx(() {
                      final selectedCategory =
                          homeController.selectedCategory.value;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Mytextcategory(
                              onPressed: () =>
                                  homeController.onSelectCategory("All"),
                              text: "All",
                              isSelected: selectedCategory == "All",
                            ),
                            const SizedBox(width: 19),
                            Mytextcategory(
                              text: "Cappuccino",
                              isSelected: selectedCategory == "Cappuccino",
                              onPressed: () =>
                                  homeController.onSelectCategory("Cappuccino"),
                            ),
                            const SizedBox(width: 19),
                            Mytextcategory(
                              text: "Espresso",
                              isSelected: selectedCategory == "Espresso",
                              onPressed: () =>
                                  homeController.onSelectCategory("Espresso"),
                            ),
                            const SizedBox(width: 19),
                            Mytextcategory(
                              text: "Coffee Beans",
                              isSelected: selectedCategory == "Coffee Beans",
                              onPressed: () => homeController.onSelectCategory(
                                "Coffee Beans",
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Obx(
                () => ItemProducts(
                  selectedCategory: homeController.selectedCategory.value,
                  onTap: (String id) {
                    final selected = homeController.selectedCategory.value;
                    if (selected == "Coffee Beans") {
                      Get.to(Beandetails(productId: id));
                    } else {
                      Get.to(CoffeDetails(productId: id));
                    }
                  },
                ),
              ),
              // const SizedBox(height: 19),
              // Padding(
              //   padding: const EdgeInsets.only(left: 30.0),
              //   child: Text(
              //     "Coffee beans",
              //     style: const TextStyle(color: White, fontSize: 16),
              //   ),
              // ),
              // const SizedBox(height: 19),
              // Obx(
              //   () => Padding(
              //     padding: const EdgeInsets.only(left: 10.0),
              //     child: ItemProducts(
              //       selectedCategory: "Coffee Beans",
              //       onTap: (String id) => {Get.to(Beandetails(productId: id))},
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
