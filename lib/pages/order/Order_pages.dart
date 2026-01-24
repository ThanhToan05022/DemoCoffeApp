import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectflutter2/pages/order/view/payment_pages.dart';

import 'package:projectflutter2/pages/profile/compoment/myAvatar.dart';
import 'package:projectflutter2/components/mySetting.dart';
import 'package:projectflutter2/pages/order/order_controller.dart';
import 'package:projectflutter2/pages/profile/profile_setting_page.dart';
import '../../model/Order.dart';
import '../../theme/NumbercurrentFormat.dart';

class OrderPages extends StatefulWidget {
  final void Function()? onPressed;
  final void Function()? onTap;

  OrderPages({super.key, this.onPressed, this.onTap});

  @override
  State<OrderPages> createState() => _OrderPagesState();
}

class _OrderPagesState extends State<OrderPages> {
  // late final List<Item> item;
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final items = orderController.cart.value.items;

        if (items == null || items.isEmpty) {
          return const Center(
            child: Text(
              'No Cart found.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final itemProduct = items[index];
                  return Column(
                    children: [
                      SizedBox(height: 7),
                      buildOrder(item: itemProduct),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Numbercurrentformat(
                        orderController.cart.value.totalPrice,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                buildButton(),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget buildButton() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Color(0xffd17842),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          // final cartSnapshot = orderController.cart.value;
          Get.to(PaymentPages());
        },
        child: Text(
          "Pay",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildOrder({required Item item}) {
    final product = item.products;
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xff262B33), Color(0xff262B33)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [infoProduct(product: product, item: item)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoProduct({required ProductsClass? product, required Item item}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product?.imageUrl ?? "",
                width: 126,
                height: 126,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12, width: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product?.name ?? "",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  product?.description ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffaeaeae),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 72,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff0c0f14),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        product?.size ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 2.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 22),
                    Text(
                      Numbercurrentformat(product?.price ?? 0),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 26,
                        height: 26,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffd17842),
                        ),
                        child: Image.asset('image/tru.png'),
                      ),
                      onTap: () => orderController.decreasePrice(item),
                    ),
                    SizedBox(width: 25, height: 52),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color(0xff0c0f14),
                        border: BoxBorder.all(
                          color: Color(0xffd17842),
                          strokeAlign: 1,
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        item.quantity.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 2,
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    GestureDetector(
                      child: Container(
                        width: 26,
                        height: 26,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xffd17842),
                        ),
                        child: Image.asset('image/cong.png'),
                      ),
                      onTap: () => orderController.increasePrice(item),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
