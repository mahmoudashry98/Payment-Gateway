class InitPaymentSheetInputModel {
  final String clientSecret;
  final String customerId;
  final String ephemeralKeySecret;
  InitPaymentSheetInputModel(
      {required this.customerId,
      required this.ephemeralKeySecret,
      required this.clientSecret});
}
