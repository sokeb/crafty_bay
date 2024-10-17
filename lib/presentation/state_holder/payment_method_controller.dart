import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class PaymentMethodController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  PaymentMethodData? _paymentMethodData;
  final List<PaymentMethod> _mobileBankingData = [];
  final List<PaymentMethod> _internetBankingData = [];
  final List<PaymentMethod> _cardData = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  PaymentMethodData? get paymentMethodData => _paymentMethodData;

  List<PaymentMethod> get mobileBankingData => _mobileBankingData;

  List<PaymentMethod> get internetBankingData => _internetBankingData;

  List<PaymentMethod> get cardData => _cardData;

  Future<bool> getPaymentMethodData(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.invoiceCreate, token: token);
    if (response.isSuccess) {
      _errorMessage = null;
      _mobileBankingData.clear();
      _internetBankingData.clear();
      _cardData.clear();

      _paymentMethodData =
          PaymentMethodModel.fromJson(response.responseData).data![0];

      for (PaymentMethod data in _paymentMethodData!.paymentMethod!) {
        if (data.type == 'mobilebanking') {
          _mobileBankingData.add(data);
        } else if (data.type == 'internetbanking') {
          _internetBankingData.add(data);
        } else {
          _cardData.add(data);
        }
      }

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
