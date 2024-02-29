
sealed class PaymentStates{}

class PaymentInitial extends PaymentStates{}

class PaymentLoading extends PaymentStates{}

class PaymentSuccess extends PaymentStates{}

class PaymentFailure extends PaymentStates{
  final String paymentFailureMessage;
  PaymentFailure({required this.paymentFailureMessage});
}

