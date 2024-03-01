import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateways/app/core/errors/failures.dart';
import 'package:payment_gateways/app/core/utils/stripe_services.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_intent_input_model.dart';
import 'package:payment_gateways/app/features/checkout/data/repository/checkout_repository.dart';

class CheckOutRepoImpl extends CheckOutRepo {
  final StripeServices stripeServices = StripeServices();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeServices.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } on StripeException catch (e) {
      return left(ServerFailure(
        message: e.error.message ?? 'Oops there was an error',
      ));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
