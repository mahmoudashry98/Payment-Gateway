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
  const MyCartView({super.key});

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
            const SizedBox(
              height: 10,
            ),
            const OrderDetailsWidget(
              title: 'Order Subtotal',
              price: 42.97,
            ),
            const OrderDetailsWidget(title: 'Discount', price: 0.00),
            const OrderDetailsWidget(title: 'Shipping', price: 42.97),
            const Divider(
              thickness: 2,
              height: 15,
            ),
            OrderDetailsWidget(
                title: 'Total',
                price: 50.76,
                textStyle: Styles.style24
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 22)),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              text: 'Complete Payment',
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    builder: (context) {
                      return BlocProvider(
                          create: (context) => PaymentCubit(CheckOutRepoImpl()),
                          child: const PaymentDetailsView());
                    });
              },
            ),
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
}

// class CustomButtonBlocConsumer extends StatelessWidget {
//   const CustomButtonBlocConsumer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<PaymentCubit, PaymentStates>(
//       listener: (context, state) {
//         if (state is PaymentSuccess) {
//           Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (context) => const SuccessCardView(),
//           ));
//         }

//         if (state is PaymentFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.paymentFailureMessage),
//             ),
//           );
//         }
//       },

//       builder: (context, state) {
//         return CustomButton(
//           isLoading: state is PaymentLoading ? true : false,
//           text: 'Complete Payment',
//           onPressed: () {
//             final PaymentIntentInputModel paymentIntentInputModel =
//                 PaymentIntentInputModel(amount: '100', currency: 'USD');

//             BlocProvider.of<PaymentCubit>(context)
//                 .makePayment(paymentIntentInputModel: paymentIntentInputModel);
//             showModalBottomSheet(
//                 isScrollControlled: false,
//                 context: context,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 builder: (context) {
//                   // return const PaymentDetailsView();
//                   return BlocProvider(
//                     create: (context) => PaymentCubit(CheckOutRepoImpl()),
//                     child: const PaymentBottomSheet(),
//                   );
//                 });
//           },
//           textColor: Colors.white,
//         );
//       },
//     );
//   }
//}
