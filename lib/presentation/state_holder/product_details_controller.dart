import 'package:crafty_bay_app/data/models/product_data_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/product_details_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<ProductDataModel>? _data;

  List<ProductDataModel>? get data => _data;

  String? get errorMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> getProductDetailsList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.productListById(productId));
    if (response.isSuccess && response.responseData["msg"] == "success") {
      isSuccess = true;
      _errorMessage = null;
      _data = ProductDetailsModel.fromJson(response.responseData).data!;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
