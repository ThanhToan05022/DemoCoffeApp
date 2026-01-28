import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:projectflutter2/components/mySetting.dart';
import 'package:projectflutter2/model/orderHistory.dart';
import 'package:projectflutter2/pages/order/history/orderHistory_controller.dart';
import 'package:projectflutter2/pages/profile/compoment/myAvatar.dart';
import 'package:projectflutter2/theme/NumbercurrentFormat.dart';

class OrderhistoryPages extends StatefulWidget {
  void Function()? onPressed;

  OrderhistoryPages({super.key, this.onPressed});

  @override
  State<OrderhistoryPages> createState() => _OrderhistoryPagesState();
}

class _OrderhistoryPagesState extends State<OrderhistoryPages> {
  final orderHistoryController = Get.find<OrderhistoryController>();

  @override
  Widget build(BuildContext context) {
    final items = orderHistoryController.orderHistory;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Mysetting(),
                const Text(
                  'Order History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Myavatar(),
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Obx(() {
                final items = orderHistoryController.orderHistory;
                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No orders',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final products = items[index];
                    return buildItemOrderHistory(item: products);
                  },
                );
              }),
            ),
            SizedBox(
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onPressed,
                  child: Text(
                    "Download",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemOrderHistory({required History? item}) {
    // final utc7Date = item?.date!.add(Duration(hours: 7));
    final localDate = item?.date?.toLocal();
    final dateFormat = DateFormat('dd/MM/yyyy').format(localDate!);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 2),
            Column(
              children: [
                Text(
                  'Order Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(dateFormat),
              ],
            ),
            Column(
              children: [
                Text(
                  'Total amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  Numbercurrentformat(item?.totalPrice),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(children: [buildUIOrderHistory(orderItem: item!.items)]),
      ],
    );
  }

  Widget buildUIOrderHistory({required List<Item>? orderItem}) {
    return Container(
      width: double.infinity,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        gradient: const LinearGradient(
          colors: <Color>[Color(0xff262B33), Color(0xff262B330)],
        ),
      ),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final items = orderItem[index];
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        items.products?.imageUrl ?? "",
                        height: 85,
                        width: 55,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13.0),
                        child: Text(
                          items.products?.name ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        items.products?.description ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff0C0F14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              items.products?.size ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                items.quantity.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 61.0),
                    child: Text(
                      Numbercurrentformat(items.products?.price),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },

            itemCount: orderItem!.length,
          ),
        ],
      ),
    );
  }
}
