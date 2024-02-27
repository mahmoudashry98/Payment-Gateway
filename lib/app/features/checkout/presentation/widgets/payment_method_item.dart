import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodItem extends StatelessWidget {
  final String image;
  final bool isActive;

  const PaymentMethodItem({
    this.isActive = false,
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: 103,
        height: 62,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isActive ? const Color(0xFF34A853) : Colors.grey,
              width: 1.50,
            ),
          ),
        ),
        child: SvgPicture.asset(
          image,
        ),
      ),
    );
  }
}
