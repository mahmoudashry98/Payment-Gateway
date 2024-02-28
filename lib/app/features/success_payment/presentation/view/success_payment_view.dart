import 'package:flutter/material.dart';
import 'package:payment_gateways/app/core/widgets/custom_appbar.dart';
import 'package:payment_gateways/app/core/widgets/custom_dish_line.dart';
import 'package:payment_gateways/app/features/success_payment/presentation/widgets/check_icon.dart';
import 'package:payment_gateways/app/features/success_payment/presentation/widgets/success_card.dart';

class SuccessPaymentView extends StatelessWidget {
  const SuccessPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Success'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const SuccessCardView(),
            Positioned(
              bottom: MediaQuery.sizeOf(context).height * .25 + 20,
              left: 20 + 8,
              right: 20 + 8,
              child: const CustomDashedLine(),
            ),
            Positioned(
                left: -20,
                bottom: MediaQuery.sizeOf(context).height * .25,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                )),
            Positioned(
                right: -20,
                bottom: MediaQuery.sizeOf(context).height * .25,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                )),
            const Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: CustomCheckIcon(),
            ),
          ],
        ),
      ),
    );
  }
}
