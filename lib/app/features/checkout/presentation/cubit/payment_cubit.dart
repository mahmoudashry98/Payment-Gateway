import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_gateways/app/core/utils/api_keys.dart';
import 'package:payment_gateways/app/features/checkout/data/model/amount_model.dart';
import 'package:payment_gateways/app/features/checkout/data/model/item_list_model.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_intent_input_model.dart';
import 'package:payment_gateways/app/features/checkout/data/repository/checkout_repository.dart';
import 'package:payment_gateways/app/features/checkout/presentation/cubit/payment_states.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit(this.checkOutRepo) : super(PaymentInitial());

  final CheckOutRepo checkOutRepo;

  static PaymentCubit get(context) => BlocProvider.of<PaymentCubit>(context);

    int activeIndex = 0;

  void changeActiveIndex(int index) {
    activeIndex = index;
    emit(ChangeActiveIndexState());
  }

  

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    var result = await checkOutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    result.fold(
      (l) => emit(PaymentFailure(paymentFailureMessage: l.message)),
      (r) => emit(PaymentSuccess()),
    );
    return;
  }

  void executePayPalPayment(BuildContext context,
      ({AmountModel amount, ItemListModel itemList}) transactionData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: ApiKeys.clientId,
          secretKey: ApiKeys.secretId,
          transactions: [
            {
              "amount": transactionData.amount.toJson(),
              "description": "The payment transaction description.",
              "item_list": transactionData.itemList.toJson(),
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            log("onSuccess: $params");
            Navigator.pop(context);
            
          },
          onError: (error) async{
            log("onError: $error");
            Navigator.pop(context);
          },
          onCancel: () {
            print('cancelled:');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void onChange(Change<PaymentStates> change) {
    log(change.toString());
    super.onChange(change);
  }
}
