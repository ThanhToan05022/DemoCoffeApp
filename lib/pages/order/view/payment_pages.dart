import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:projectflutter2/api/notification_services.dart';
import 'package:projectflutter2/components/mybackButton.dart';
import 'package:projectflutter2/pages/order/order_controller.dart';
import 'package:projectflutter2/pages/order/view/payment_controller.dart';
import 'package:projectflutter2/pages/order/view/success_payment.dart';
import 'package:projectflutter2/theme/Theme.dart';

import '../../../theme/NumbercurrentFormat.dart';
import '../history/orderHistory_controller.dart';

class PaymentPages extends StatefulWidget {
  final void Function()? onTap;

  PaymentPages({super.key, this.onTap});

  @override
  State<PaymentPages> createState() => _PaymentPagesState();
}

class _PaymentPagesState extends State<PaymentPages> {
  final paymentController = Get.find<PaymentController>();
  final orderController = Get.find<OrderController>();
  final orderHistoryController = Get.find<OrderhistoryController>();
  String? selectedpaymentMethod;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Mybackbutton(),
                ),
                SizedBox(width: 99),
                Text(
                  'Payment',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            buildVisaCard(),
            SizedBox(height: 10),
            buildItemCardWallet(image: 'image/wallet.png', text: 'Wallet'),
            SizedBox(height: 10),
            buildItemCard(image: 'image/googlepay.png', text: 'Google Pay'),
            SizedBox(height: 10),
            buildItemCard(image: 'image/apple.png', text: 'Apple Pay'),
            SizedBox(height: 10),
            buildItemCard(image: 'image/amazon.png', text: 'Amazon Pay'),
            SizedBox(height: 250),
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
                    const SizedBox(height: 6),
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
        ),
      ),
    );
  }

  Widget buildVisaCard() {
    return Container(
      width: double.infinity,
      // height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: BoxBorder.all(color: radius, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credit Card',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            // SizedBox(height: 10, width: 10),
            Image.asset('image/visa.png', fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }

  Widget buildItemCardWallet({required String image, required String? text}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: BoxBorder.all(color: Color(0xff262b33), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            paymentController.selectPayment(text);
            Get.snackbar('Selected', text, snackPosition: SnackPosition.BOTTOM);
          },
          child: Row(
            children: [
              Image.asset(image, fit: BoxFit.cover),
              SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 240)),
              Text(
                "\$ ${100.50}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemCard({required String image, required String text}) {
    return SizedBox(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: BoxBorder.all(color: Color(0xff262b33), width: 2),
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 17.0),
          child: TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              paymentController.selectPayment(text);
              Get.snackbar(
                'Selected',
                text,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Row(
              children: [
                Image.asset(image, fit: BoxFit.cover),
                SizedBox(width: 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
        onPressed: () async {
          try {
            await orderHistoryController.createCheckout();
             await NotificationServices().showNotification(
                title: 'Thanh toán',
                body: 'Bạn đã thanh toán thành công đơn hàng');

            Get.to(SuccessPayment());
          } catch (e) {
            print(e);
          }
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
}
