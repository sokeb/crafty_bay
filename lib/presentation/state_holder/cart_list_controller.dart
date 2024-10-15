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
  int _totalBill = 0;

  int get totalBill => _totalBill;

  final Map<String, int> _quantity = {};

  final Map<String, int> _productPrice = {};
  final Map<String, int> _totalProductPrice = {};

  Map<String, int> get quantity => _quantity;

  Map<String, int> get productPrice => _productPrice;

  Map<String, int> get totalProductPrice => _totalProductPrice;

  Future<bool> getCartProductList(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.cartList, token: token);
    if (response.isSuccess) {
      _errorMessage = null;
      _cartList = CartListModel.fromJson(response.responseData).cartData ?? [];
      _totalBill = 0;
      for (CartDataModel cartData in cartList) {
        _totalBill += int.parse(cartData.price!);
        _quantity[cartData.productData!.id.toString()] =
            int.parse(cartData.qty!);
        _totalProductPrice[cartData.productData!.id.toString()] =
            int.parse(cartData.price!);
        _productPrice[cartData.productData!.id.toString()] =
            (int.parse(cartData.price!) / int.parse(cartData.qty!)).round();
      }
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  // Change quantity for a specific product
  void updateCard(String productId, bool increase) {
    int currentQty = _quantity[productId] ?? 1;
    if (increase) {
      _quantity[productId] = currentQty + 1;
      _totalProductPrice[productId] =
          _totalProductPrice[productId]! + _productPrice[productId]!;
      _totalBill = _totalBill + _productPrice[productId]!;
    } else if (currentQty > 1) {
      _quantity[productId] = currentQty - 1;
      _totalProductPrice[productId] =
          _totalProductPrice[productId]! - _productPrice[productId]!;
      _totalBill = _totalBill - _productPrice[productId]!;
    }
    update(); // Notify GetX to update the UI
  }

  Future<bool> deleteCartProductList(int productId, String token) async {
    bool isSuccess = false;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.deleteCartList(productId), token: token);
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
