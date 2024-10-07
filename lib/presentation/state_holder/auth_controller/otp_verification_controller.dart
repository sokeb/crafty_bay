import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utils/url.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  bool _isProgress = false;
  String? _errorMessage ;
  String _data = '';

  bool get inProgress => _isProgress;
  String? get errorMessage => _errorMessage;
  String get token => _data;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _isProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.otpVerification(email, otp));

    if(response.statusCode == 200 && response.responseData['msg'] == 'success'){
      _errorMessage = null;
      isSuccess = true;
      _data = response.responseData['data'];
    }else{
      _errorMessage = response.errorMessage;
    }
    _isProgress = false;
    update();
    return isSuccess;
  }
}
