import 'package:crafty_bay_app/data/models/cart_list_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class CartListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<CartDataModel> _cartList = [];

  List<CartDataModel> get cartList => _cartList;

  Future<bool> getCartProductList(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.cartList, token: token);
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _cartList = CartListModel.fromJson(response.responseData).cartData ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
