import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utils/url.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/user_model.dart';

class ReadProfileController extends GetxController {
  bool _isProgress = false;
  bool _isProfileCreated = false;
  String? _errorMessage;

  UserModel? _userModel;

  bool get inProgress => _isProgress;

  bool get isProfileCreated => _isProfileCreated;

  String? get errorMessage => _errorMessage;

  UserModel? get userModel => _userModel;

  Future<bool> getProfileData(String token) async {
    bool isSuccess = false;
    _isProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Url.readProfile, token: Get.find<AuthController>().token);

    if (response.statusCode == 200 &&
        response.responseData['msg'] == 'success') {
      _errorMessage = null;
      if (response.responseData['data'] != null) {
        _userModel = UserModel.fromJson(response.responseData['data']);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await Get.find<AuthController>()
            .saveUserData(_userModel!, localStorage);
        localStorage.setBool("hasUserData", true);
        _isProfileCreated = true;
      } else {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setBool("hasUserData", false);
      }
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isProgress = false;
    update();
    return isSuccess;
  }

  void clearData(){
    _userModel = null;
    update();
  }

}
