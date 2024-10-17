import 'package:crafty_bay_app/presentation/ui/screen/payment_method_screen/payment_method_card.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/payment_method_model.dart';

class Banking extends StatelessWidget {
  const Banking({super.key, required this.data});

  final List<PaymentMethod> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentMethodsCard(bankingData: data),
    );
  }
}
