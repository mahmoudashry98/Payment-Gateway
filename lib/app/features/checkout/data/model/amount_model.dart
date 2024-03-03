class AmountModel {
  final String? total;
  final String? currency;
  final Details? details;

  AmountModel({required this.total, required this.currency, required this.details});

  factory AmountModel.fromJson(Map<String, dynamic> json) {
    return AmountModel(
      total: json['total'] as String,
      currency: json['currency'] as String,
      details: json['details'] == null ? null : Details.fromJson(json['details'] as Map<String, dynamic>),
    );
  }

  Map<String,dynamic> toJson() => {
    'total': total,
    'currency': currency,
    'details': details?.toJson(),
  };
}

class Details {
  final String? subtotal;
  final String? shipping;
  final int? shippingDiscount;

  Details({ this.subtotal,  this.shipping,  this.shippingDiscount});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      subtotal: json['subtotal'],
      shipping: json['shipping'],
      shippingDiscount: json['shipping_discount'],
    );
  }

  Map<String,dynamic> toJson() => {
    'subtotal': subtotal,
    'shipping': shipping,
    'shipping_discount': shippingDiscount,
  };
}