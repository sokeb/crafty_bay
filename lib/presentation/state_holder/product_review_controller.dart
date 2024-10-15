import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/review_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class ProductReviewController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<ReviewListData>? _reviewList;

  List<ReviewListData>? get reviewList => _reviewList;

  Future<bool> getReviewList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Url.listReviewByProduct(productId));
    if (response.isSuccess) {
      _errorMessage = null;
      _reviewList = ReviewListModel.fromJson(response.responseData).data;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
