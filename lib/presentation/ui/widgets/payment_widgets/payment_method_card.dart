import 'package:crafty_bay_app/presentation/ui/screen/payment_method_screen/payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../data/models/payment_method_model.dart';
import '../../../state_holder/web_view_controller.dart';

class PaymentMethodsCard extends StatelessWidget {
  const PaymentMethodsCard({
    super.key,
    required this.bankingData,
  });

  final List<PaymentMethod> bankingData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: bankingData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1.0, // Updated spacing for better layout
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.find<PaymentWebViewController>().resetController();
              Get.off(()=> WebViewStack(redirectGatewayURL: bankingData[index].redirectGatewayURL!));
            },
            child: Card(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //color: AppColors.themeColor.withOpacity(0.1),
                  image: DecorationImage(
                    image: NetworkImage(bankingData[index].logo!),
                    fit: BoxFit.scaleDown, // Updated fit for better scaling
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
