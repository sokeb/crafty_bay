import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:crafty_bay_app/data/models/product_list_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class NewProductListController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  List<ProductModel> _productList = [];

  String? get errorMessage => _errorMessage;

  List<ProductModel> get newProductList => _productList;

  bool get inProgress => _inProgress;

  Future<bool> getNewProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.productListByRemark('new'));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _productList =
          ProductsListModel.fromJson(response.responseData).productList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
