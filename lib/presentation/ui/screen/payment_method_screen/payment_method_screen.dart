import 'package:crafty_bay_app/presentation/state_holder/web_view_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/payment_widgets/payment_updates.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key, required this.redirectGatewayURL});

  final String redirectGatewayURL;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<PaymentWebViewController>(builder: (controller) {
          if (controller.isPaymentPending) {
            return WebViewWidget(
                controller:
                    controller.configureController(widget.redirectGatewayURL));
          }
          if (controller.isPaymentSuccess) {
            if(controller.isPaymentSuccess){
              const LoadingIndicator();
            }
            return const PaymentStatus(
              headerText: "payment Successful",
              subtitleText: "thanks for oder with crafty bay ",
              isSuccess: true,
            );
          }
          return const PaymentStatus(
            headerText: 'paymentFailure',
            subtitleText: 'PpaymentFailureSubtitleText',
            isSuccess: false,
          );
        }),
      ),
    );
  }
}