import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:projectflutter2/components/mySetting.dart';
import 'package:projectflutter2/model/orderHistory.dart';
import 'package:projectflutter2/pages/order/history/orderHistory_controller.dart';
import 'package:projectflutter2/pages/profile/compoment/myAvatar.dart';

class OrderhistoryPages extends StatefulWidget {
  const OrderhistoryPages({super.key});

  @override
  State<OrderhistoryPages> createState() => _OrderhistoryPagesState();
}

class _OrderhistoryPagesState extends State<OrderhistoryPages> {
  final orderHistoryController = Get.find<OrderhistoryController>();

  @override
  Widget build(BuildContext context) {
    final items = orderHistoryController.orderHistory.value;
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
          ],
        ),
      ),
    );
  }

  Widget buildItemOrderHistory({required Datum item}) {
    final dateFormat = DateFormat('dd/MM/yyyy : hh:mm:ss').format(item.date!);
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
                Text(
                  dateFormat,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
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
                  item.totalPrice.toString(),
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
      ],
    );
  }

}
