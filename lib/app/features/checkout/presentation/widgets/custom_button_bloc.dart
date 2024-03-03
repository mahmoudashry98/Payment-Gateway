import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateways/app/core/widgets/custom_app_button.dart';
import 'package:payment_gateways/app/features/checkout/data/model/amount_model.dart';
import 'package:payment_gateways/app/features/checkout/data/model/item_list_model.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_intent_input_model.dart';
import 'package:payment_gateways/app/features/checkout/presentation/cubit/payment_cubit.dart';
import 'package:payment_gateways/app/features/checkout/presentation/cubit/payment_states.dart';
import 'package:payment_gateways/app/features/checkout/presentation/views/success_payment_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final paymentCubit = PaymentCubit.get(context);
    return BlocConsumer<PaymentCubit, PaymentStates>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const SuccessPaymentView(),
          ));
        }

        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar =
              SnackBar(content: Text(state.paymentFailureMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
          isLoading: state is PaymentLoading ? true : false,
          text: 'Pay',
          onPressed: () {
            if (paymentCubit.activeIndex == 0) {
              final PaymentIntentInputModel paymentIntentInputModel =
                  PaymentIntentInputModel(
                      amount: '100',
                      currency: 'USD',
                      customerId: 'cus_PegTupxxNhENxJ');

              paymentCubit.makePayment(
                  paymentIntentInputModel: paymentIntentInputModel);
            } else {
              var transactionData = getTransactionData();
              paymentCubit.executePayPalPayment(context, transactionData);
            }
            var transactionData = getTransactionData();
            paymentCubit.executePayPalPayment(context, transactionData);
          },
          textColor: Colors.white,
        );
      },
    );
  }

  ({AmountModel amount, ItemListModel itemList}) getTransactionData() {
    var amount = AmountModel(
      total: "100",
      currency: "USD",
      details: Details(shipping: "0", shippingDiscount: 0, subtotal: "100"),
    );
    List<OrderItemModel> orders = [
      OrderItemModel(
        name: "Apple",
        quantity: 4,
        price: '10',
        currency: "USD",
      ),
      OrderItemModel(
        name: "Pineapple",
        quantity: 5,
        price: '12',
        currency: "USD",
      ),
    ];

    var itemList = ItemListModel(orders: orders);

    return (amount: amount, itemList: itemList);
  }
}
