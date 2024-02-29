import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateways/app/core/utils/api_keys.dart';
import 'package:payment_gateways/app/core/utils/api_service.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_inten_model/payment_inten_model.dart';
import 'package:payment_gateways/app/features/checkout/data/model/payment_intent_input_model.dart';

class StripeServices {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretKey,
      contentType: 'application/x-www-form-urlencoded',
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentIntent({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'Mahmoud Ashry',
    ));
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var paymentIntentClientSecret = paymentIntentModel.clientSecret;
    await initPaymentIntent(paymentIntentClientSecret: paymentIntentClientSecret!);
    await displayPaymentSheet();
  }
}
