import 'package:flutter/material.dart';
import 'package:payment_gateways/app/core/utils/styles.dart';

class CartItemDetails extends StatelessWidget {
  const CartItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              _buildCounterWithPrice()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCounterWithPrice() {
    return Row(
      children: [
        Container(
          height: 40,
          width: 110,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }
}
