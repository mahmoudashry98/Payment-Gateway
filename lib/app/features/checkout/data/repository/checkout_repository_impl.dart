import 'package:dartz/dartz.dart';
import 'package:payment_gateways/app/core/errors/failures.dart';
import 'package:payment_gateways/app/core/utils/stripe_services.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_intent_input_model.dart';
import 'package:payment_gateways/app/features/checkout/data/repository/checkout_repository.dart';

class CheckOutRepoImpl extends CheckOutRepo {
  final StripeServices stripeServices = StripeServices();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async{
    try {
    await stripeServices.makePayment(paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
