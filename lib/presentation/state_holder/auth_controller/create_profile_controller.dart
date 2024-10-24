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

  Future<bool> createProfile(
      {required String firstName,
      required String lastName,
      required String mobile,
      required String city,
        required String address,
        required String postcode,
        required String country,
      required String shippingAddress,
        required String token,
      }) async {
    bool isSuccess = false;
    _isProgress = true;
    update();

    Map<String, String> json = {
      "cus_name": "$firstName $lastName",
      "cus_add": address,
      "cus_city": city,
      "cus_state": city,
      "cus_postcode": postcode,
      "cus_country": country,
      "cus_phone": mobile,
      "cus_fax": mobile,
      "ship_name": firstName + lastName,
      "ship_add": shippingAddress,
      "ship_city": city,
      "ship_state": city,
      "ship_postcode": postcode,
      "ship_country": country,
      "ship_phone": mobile
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(
            url: Url.createProfile,
            body: json, token: Get.find<AuthController>().token);

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
