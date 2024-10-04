import 'package:crafty_bay_app/data/models/product_details_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  ProductDetailsModel? _productDetails;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  ProductDetailsModel? get productDetails => _productDetails;

  bool get inProgress => _inProgress;

  Future<bool> getProductDetailsList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.productListById(productId));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _productDetails =
          ProductDetailsModel.fromJson(response.responseData["data"][0]);
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
