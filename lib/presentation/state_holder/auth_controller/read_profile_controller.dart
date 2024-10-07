import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utils/url.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _isProgress = false;
  bool _isProfileCreated = false;
  String? _errorMessage ;
  String? _data;

  bool get inProgress => _isProgress;
  bool get isProfileCreated => _isProfileCreated;
  String? get errorMessage => _errorMessage;
  String? get token => _data;

  Future<bool> getProfileData(String token) async {
    bool isSuccess = false;
    _isProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.readProfile, token: token);

    if(response.statusCode == 200 && response.responseData['msg'] == 'success'){
      _errorMessage = null;
      if(response.responseData['data'] != null){
        _isProfileCreated = true;
      }
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _isProgress = false;
    update();
    return isSuccess;
  }
}
