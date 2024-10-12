import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utils/url.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/user_model.dart';

class CreateCartListController extends GetxController {
  bool _isProgress = false;

  bool get inProgress => _isProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> createCartList({
    required int productId,
    required String color,
    required String size,
    required int qty,
    required String token,
  }) async {
    bool isSuccess = false;
    _isProgress = true;
    update();

    Map<String, dynamic> json = {
      "product_id": productId,
      "color": color,
      "size": size,
      "qty": qty
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Url.createCartList, body: json, token: token);

    if (response.statusCode == 200 &&
        response.responseData['msg'] == 'success') {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isProgress = false;
    update();
    return isSuccess;
  }
}
