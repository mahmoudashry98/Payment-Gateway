import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_intent_input_model.dart';
import 'package:payment_gateways/app/features/checkout/data/repository/checkout_repository.dart';
import 'package:payment_gateways/app/features/checkout/presentation/cubit/payment_states.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit(this.checkOutRepo) : super(PaymentInitial());

  final CheckOutRepo checkOutRepo;

  static PaymentCubit get(context) => BlocProvider.of<PaymentCubit>(context);

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

  @override
  void onChange(Change<PaymentStates> change) {
    log(change.toString());
    super.onChange(change);
  }
}