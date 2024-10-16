import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class CreateWishListController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> createWishlist(int productId, String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: Url.createWishList(productId), token: token);
    if (response.statusCode == 200 &&
        response.responseData['msg'] == 'success') {
      _errorMessage = null;
      isSuccess = true;
    }else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
