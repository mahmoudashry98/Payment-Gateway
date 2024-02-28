import 'package:flutter/material.dart';

class OrderDetailsWidget extends StatelessWidget {
  final String title;
  final double price;
  final TextStyle? textStyle;

  const OrderDetailsWidget(
      {super.key, required this.title, required this.price, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: textStyle ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: textStyle ?? const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
