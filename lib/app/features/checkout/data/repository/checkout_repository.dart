import 'package:dartz/dartz.dart';
import 'package:payment_gateways/app/core/errors/failures.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_intent_input_model.dart';

abstract class CheckOutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
