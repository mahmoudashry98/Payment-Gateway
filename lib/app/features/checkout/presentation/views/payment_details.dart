import 'package:flutter/material.dart';

import 'package:payment_gateways/app/core/widgets/custom_button_app.dart';
import 'package:payment_gateways/app/features/checkout/presentation/widgets/payment_method_item.dart';

class PaymentDetailsView extends StatefulWidget {
  const PaymentDetailsView({super.key});

  @override
  State<PaymentDetailsView> createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/svg/card.svg',
      'assets/svg/paypal.svg',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPaymentMethods(images),
          const SizedBox(
            height: 20,
          ),
          CustomButton(text: 'Pay', onPressed: () {}),
        ],
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

// class CustomCreditCard extends StatefulWidget {
//   final GlobalKey<FormState> formKey;
//   final AutovalidateMode autovalidateMode;
//   const CustomCreditCard({
//     required this.formKey,
//     required this.autovalidateMode,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CustomCreditCard> createState() => _CustomCreditCardState();
// }

// class _CustomCreditCardState extends State<CustomCreditCard> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool showBackView = false;

//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       showBackView = creditCardModel.isCvvFocused;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CreditCardWidget(
//           cardBgColor: Colors.grey,
//           cardNumber: cardNumber,
//           expiryDate: expiryDate,
//           cardHolderName: cardHolderName,
//           cvvCode: cvvCode,
//           showBackView: showBackView,
//           isHolderNameVisible: true,
//           padding: 0,
//           onCreditCardWidgetChange: (value) {},
//         ),
//         CreditCardForm(
//           autovalidateMode: widget.autovalidateMode,
//           cardNumber: cardNumber,
//           expiryDate: expiryDate,
//           cardHolderName: cardHolderName,
//           cvvCode: cvvCode,
//           onCreditCardModelChange: onCreditCardModelChange,
//           formKey: widget.formKey,
//         )
//       ],
//     );
//   }
// }
