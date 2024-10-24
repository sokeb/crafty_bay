import 'package:crafty_bay_app/presentation/ui/widgets/payment_widgets/payment_method_card.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/payment_method_model.dart';

class InternetBanking extends StatelessWidget {
  const InternetBanking({super.key, required this.data});

  final List<PaymentMethod> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PaymentMethodsCard(bankingData: data));
  }
}
