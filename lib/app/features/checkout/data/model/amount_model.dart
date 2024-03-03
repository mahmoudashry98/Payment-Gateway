class AmountModel {
  final String total;
  final String currency;
  final Map<String, dynamic> details;

  AmountModel({required this.total, required this.currency, required this.details});

  factory AmountModel.fromJson(Map<String, dynamic> json) {
    return AmountModel(
      total: json['total'],
      currency: json['currency'],
      details: json['details'],
    );
  }
}