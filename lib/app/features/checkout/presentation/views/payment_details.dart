// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:payment_gateways/app/core/widgets/custom_appbar.dart';
import 'package:payment_gateways/app/features/checkout/presentation/widgets/payment_method_item.dart';

class PaymentDetailsView extends StatefulWidget {
  const PaymentDetailsView({super.key});

  @override
  State<PaymentDetailsView> createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  int activeIndex = 0;
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/svg/card.svg',
      'assets/svg/paypal.svg',
    ];
    return Scaffold(
      appBar: customAppBar(context, title: 'Payment Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(images.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      child: PaymentMethodItem(
                        image: images[index],
                        isActive: activeIndex == index,
                      ),
                    );
                  }),
                ),
                CustomCreditCard(
                  cardNumber: '',
                  expiryDate: '',
                  cardHolderName: '',
                  cvvCode: '',
                  onCreditCardModelChange: (p0) {},
                  formKey: formKey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCreditCard extends StatefulWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final Function(CreditCardModel) onCreditCardModelChange;
  final GlobalKey<FormState> formKey;
  const CustomCreditCard({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.onCreditCardModelChange,
    required this.formKey,
  }) : super(key: key);

  @override
  State<CustomCreditCard> createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardForm(
          cardNumber: widget.cardNumber,
          expiryDate: widget.expiryDate,
          cardHolderName: widget.cardHolderName,
          cvvCode: widget.cvvCode,
          onCreditCardModelChange: widget.onCreditCardModelChange,
          formKey: widget.formKey,
        ),
      ],
    );
  }
}
