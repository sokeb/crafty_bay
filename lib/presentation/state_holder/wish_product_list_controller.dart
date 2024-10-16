import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/wish_product_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class WishProductListController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  List<WishProductData> _wishProductList = [];

  String? get errorMessage => _errorMessage;

  List<WishProductData> get wishProductList => _wishProductList;

  bool get inProgress => _inProgress;

  Future<bool> getWishProductList(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(url: Url.productWishList, token: token);
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _wishProductList =
          WishProductModel.fromJson(response.responseData).productData ??
              [];
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
