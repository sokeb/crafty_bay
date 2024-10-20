import 'package:crafty_bay_app/presentation/state_holder/cart_list_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewController extends GetxController {
  bool _isInProgress = true;
  bool _isPaymentSuccess = false;
  bool _isPaymentPending = true;

  bool get isInProgress => _isInProgress;
  bool get isPaymentSuccess => _isPaymentSuccess;

  bool get isPaymentPending => _isPaymentPending;

  WebViewController configureController(String redirectGatewayURL) {

    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onPageFinished: (String url) async {
            if (url.startsWith(
                "https://ecommerce-api.codesilicon.com/api/PaymentSuccess")) {
              _isPaymentSuccess = true;
              _isPaymentPending = false;
              _isInProgress= true;
              Get.find<CartListController>().removeAllCartProduct();
              _isInProgress= false;
              update();
            }
            if (url.startsWith(
                "https://ecommerce-api.codesilicon.com/api/PaymentFail")) {
              _isPaymentSuccess = false;
              _isPaymentPending = false;
              await Future.delayed(const Duration(seconds: 2));
              update();
            }
          },
          onNavigationRequest: (NavigationRequest navigationRequest) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          redirectGatewayURL.toString(),
        ),
      );
  }

  void resetController(){
    _isPaymentSuccess = false;
    _isPaymentPending = true;
    update();
  }

}
