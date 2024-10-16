import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utils/url.dart';
import 'package:get/get.dart';

class CreateProductReviewController extends GetxController {
  bool _isProgress = false;

  bool get inProgress => _isProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> createReview(
      {required int productId,
      required int rating,
      required String review,
      required String token}) async {
    bool isSuccess = false;
    _isProgress = true;
    update();

    Map<String, dynamic> json = {
      "description": review,
      "product_id": productId,
      "rating": rating
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Url.createProductReview, body: json, token: token);

    if (response.statusCode == 200 &&
        response.responseData['msg'] == 'success') {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? "An error occurred. Please try again.";
    }
    _isProgress = false;
    update();
    return isSuccess;
  }
}
