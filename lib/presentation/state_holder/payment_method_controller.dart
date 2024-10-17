import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class PaymentMethodController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  List<PaymentMethodData> _paymentMethodData = [];

  String? get errorMessage => _errorMessage;

  List<PaymentMethodData> get paymentMethodData => _paymentMethodData;

  bool get inProgress => _inProgress;

  Future<bool> getPaymentMethodData(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: Url.invoiceCreate, token: token);
    if (response.isSuccess) {
      _errorMessage = null;
      _paymentMethodData =
          PaymentMethodModel.fromJson(response.responseData).data ??
              [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
