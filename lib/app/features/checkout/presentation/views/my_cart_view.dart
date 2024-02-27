import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:payment_gateways/app/core/utils/styles.dart';
import 'package:payment_gateways/app/core/widgets/button_app.dart';
import 'package:payment_gateways/app/features/checkout/presentation/widgets/order_details_widget.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: Styles.style25,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: Image.asset('assets/images/cart.jpeg'),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/amount_container.png',
                      ),
                      Positioned(
                        top: 10,
                        left: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'kinetic Sand Dino\nDig PlaySet',
                              style: Styles.style18,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          // Handle minus button press
                                        },
                                      ),
                                      const Text(
                                        '5', // Replace with your desired number
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          // Handle plus button press
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '\$ 19.00',
                                  style: Styles.styleBold18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const OrderDetailsWidget(
              title: 'Order Subtotal',
              price: 42.97,
            ),
            const OrderDetailsWidget(title: 'Discount', price: 0.00),
            const OrderDetailsWidget(title: 'Shipping', price: 42.97),
            const Divider(),
            OrderDetailsWidget(
                title: 'Total',
                price: 50.76,
                textStyle: Styles.style24
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 22)),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              text: 'Complete Payment',
              onPressed: () {},
              textColor: Colors.white,
              buttonColor: const Color(0xFF34A853),
            )
          ],
        ),
      ),
    );
  }
}