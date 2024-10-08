import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utils/url.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/user_model.dart';

class CreateProfileController extends GetxController {
  bool _isProgress = false;

  bool get inProgress => _isProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // UserModel? _userModel;
  //
  // UserModel? get userModel => _userModel;

  Future<bool> createProfile(
      {required String firstName,
      required String lastName,
      required String mobile,
      required String city,
      required String shippingAddress,
        required String token,
      }) async {
    bool isSuccess = false;
    _isProgress = true;
    update();

    Map<String, String> json = {
      "cus_name": "${firstName} ${lastName}",
      "cus_add": shippingAddress,
      "cus_city": city,
      "cus_state": city,
      "cus_postcode": "1207",
      "cus_country": "Bangladesh",
      "cus_phone": mobile,
      "cus_fax": mobile,
      "ship_name": firstName + lastName,
      "ship_add": shippingAddress,
      "ship_city": city,
      "ship_state": city,
      "ship_postcode": "1207",
      "ship_country": "Bangladesh",
      "ship_phone": mobile
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(
            url: Url.readProfile,
            body: json,
            token: token);

    if (response.statusCode == 200 &&
        response.responseData['msg'] == 'success') {
      _errorMessage = null;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setBool("hasUserData", true);

      UserModel userModel = UserModel.fromJson(response.responseData['data']);
      await Get.find<AuthController>().saveUserData(userModel, localStorage);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isProgress = false;
    update();
    return isSuccess;
  }
}
