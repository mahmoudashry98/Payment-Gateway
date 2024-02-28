import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payment_gateways/app/core/utils/styles.dart';
import 'package:payment_gateways/app/features/success_payment/presentation/widgets/card_info.dart';
import 'package:payment_gateways/app/features/success_payment/presentation/widgets/payment_item_info.dart';
import 'package:payment_gateways/app/features/success_payment/presentation/widgets/total_price.dart';

class SuccessCardView extends StatelessWidget {
  const SuccessCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFEDEDED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 55, left: 10, right: 10),
        child: Column(
          children: [
            const Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: Styles.style25,
            ),
            const Text(
              'Your transaction was successful',
              textAlign: TextAlign.center,
              style: Styles.style20,
            ),
            const SizedBox(
              height: 20,
            ),
            const PaymentItemInfo(
              title: 'Date',
              value: '01/24/2023',
            ),
            const SizedBox(
              height: 10,
            ),
            const PaymentItemInfo(
              title: 'Time',
              value: '10:15 AM',
            ),
            const SizedBox(
              height: 20,
            ),
            const PaymentItemInfo(
              title: 'To',
              value: 'Sam Louis',
            ),
            const Divider(
              height: 50,
              thickness: 2,
            ),
            const TotalPrice(title: 'Total', value: r'$50.97'),
            const SizedBox(
              height: 85,
            ),
            const CardInfoWidget(),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    FontAwesomeIcons.barcode,
                    size: 64,
                  ),
                  Container(
                    width: 113,
                    height: 58,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1.50, color: Color(0xFF34A853)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'PAID',
                        textAlign: TextAlign.center,
                        style: Styles.style24
                            .copyWith(color: const Color(0xff34A853)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
