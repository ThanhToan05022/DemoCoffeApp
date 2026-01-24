import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:projectflutter2/theme/Theme.dart';

import '../../../model/Products.dart';
import '../home_controller.dart';

class Mysearchproducts extends StatefulWidget {
  Mysearchproducts({super.key});

  @override
  State<Mysearchproducts> createState() => _MysearchproductsState();
}

class _MysearchproductsState extends State<Mysearchproducts> {
  final homeController = Get.find<HomeController>();

  void productsSearch(String name) async {
    homeController.listDatumSearch.clear();
    final result = await homeController.searchProducts(name);
    print(result);
    homeController.listDatumSearch.addAll(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            width: 350,
            height: 60,
            decoration: BoxDecoration(
              color: search,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.white),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 19.0),
                      child: TextField(
                        controller: homeController.searchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          hintText: "Find your coffe",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        onSubmitted: (value) {
                          productsSearch(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.listDatumSearch.length,
          itemBuilder: (context, index) {
            final item = homeController.listDatumSearch[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl ?? '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(item.name ?? 'Sản phẩm không tên'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${(item.price ?? 0).toInt()}",
                    style: TextStyle(fontSize: 14, color: White),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description ?? "Không có mô tả",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: White, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
