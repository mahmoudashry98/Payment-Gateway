// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:payment_gateways/app/core/widgets/custom_appbar.dart';
import 'package:payment_gateways/app/core/widgets/custom_button_app.dart';
import 'package:payment_gateways/app/features/checkout/presentation/widgets/payment_method_item.dart';
import 'package:payment_gateways/app/features/success_payment/presentation/view/success_payment_view.dart';

class PaymentDetailsView extends StatefulWidget {
  const PaymentDetailsView({super.key});

  @override
  State<PaymentDetailsView> createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  int activeIndex = 0;

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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildPaymentMethods(images),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: CustomCreditCard(
                formKey: formKey,
                autovalidateMode: autovalidateMode,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    text: 'Pay',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SuccessPaymentView(),
                        ));
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods(List<String> images) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        images.length,
        (index) {
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
        },
      ),
    );
  }
}

class CustomCreditCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  const CustomCreditCard({
    required this.formKey,
    required this.autovalidateMode,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCreditCard> createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
          cardBgColor: Colors.grey,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          showBackView: showBackView,
          isHolderNameVisible: true,
          padding: 0,
          onCreditCardWidgetChange: (value) {},
        ),
        CreditCardForm(
          autovalidateMode: widget.autovalidateMode,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          onCreditCardModelChange: onCreditCardModelChange,
          formKey: widget.formKey,
        )
      ],
    );
  }
}
