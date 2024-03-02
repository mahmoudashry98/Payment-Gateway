import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateways/app/core/utils/styles.dart';
import 'package:payment_gateways/app/core/widgets/custom_app_button.dart';
import 'package:payment_gateways/app/core/widgets/custom_app_bar.dart';
import 'package:payment_gateways/app/core/widgets/payment_medthods_bottom_sheet.dart';
import 'package:payment_gateways/app/features/checkout/presentation/views/payment_details.dart';
import 'package:payment_gateways/app/features/checkout/presentation/widgets/order_details_widget.dart';
import 'package:payment_gateways/app/features/checkout/data/repository/checkout_repository_impl.dart';
import 'package:payment_gateways/app/features/checkout/presentation/cubit/payment_cubit.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'My Cart'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCartItems(),
            const SizedBox(height: 10),
            _buildOrderDetails('Order Subtotal', 42.97),
            _buildOrderDetails('Discount', 0.00),
            _buildOrderDetails('Shipping', 42.97),
            const Divider(thickness: 2, height: 15),
            _buildOrderDetails('Total', 50.76,
                textStyle: Styles.style24
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 22)),
            const SizedBox(height: 15),
            _buildCompletePaymentButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    return Stack(
      children: [
        SizedBox(
          height: 350,
          width: double.infinity,
          child: Image.asset('assets/images/cart.jpeg'),
        ),
        const Positioned(
          top: 5,
          right: 10,
          child: CartItemDetails(),
        )
      ],
    );
  }

  Widget _buildOrderDetails(String title, double price,
      {TextStyle? textStyle}) {
    return OrderDetailsWidget(
      title: title,
      price: price,
      textStyle: textStyle,
    );
  }

  Widget _buildCompletePaymentButton(BuildContext context) {
    return CustomButton(
      text: 'Complete Payment',
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          builder: (context) {
            return BlocProvider(
              create: (context) => PaymentCubit(CheckOutRepoImpl()),
              child: const PaymentDetailsView(),
            );
          },
        );
      },
    );
  }
}
