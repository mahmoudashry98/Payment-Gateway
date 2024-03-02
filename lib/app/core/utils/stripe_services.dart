import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateways/app/core/utils/api_keys.dart';
import 'package:payment_gateways/app/core/utils/api_service.dart';
import 'package:payment_gateways/app/features/checkout/data/model/ephermeral_key_model/ephermeral_key_model.dart';
import 'package:payment_gateways/app/features/checkout/data/model/init_payment_sheet_input_model.dart';
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
      contentType: Headers.formUrlEncodedContentType,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentIntent(
      {required InitPaymentSheetInputModel initPaymentSheetInput}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: initPaymentSheetInput.clientSecret,
      customerEphemeralKeySecret: initPaymentSheetInput.ephemeralKeySecret,
      customerId: initPaymentSheetInput.customerId,
      merchantDisplayName: 'Mahmoud Ashry',
    ));
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (e) {
      log('$e');
    }
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKeyModel = await createEphemeralKey(
        customerId: paymentIntentInputModel.customerId!);
    var initPaymentSheetInputModel = InitPaymentSheetInputModel(
      customerId: paymentIntentInputModel.customerId!,
      ephemeralKeySecret: ephemeralKeyModel.secret!,
      clientSecret: paymentIntentModel.clientSecret!,
    );
    await initPaymentIntent(initPaymentSheetInput: initPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await apiService.post(
        body: {'customer': customerId},
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secretKey,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Stripe-Version': '2023-08-16'
        });

    var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyModel;
  }
}
