import 'package:flutter/material.dart';
import 'package:payment_gateways/app/core/utils/styles.dart';

AppBar customAppBar(BuildContext context, {required final String title}) {
  return AppBar(
    title: Text(
      title,
      style: Styles.style25,
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.of(context).pop(),
    ),
  );
}
