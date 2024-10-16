import 'package:crafty_bay_app/data/models/categories_list_model.dart';
import 'package:crafty_bay_app/data/models/categories_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class CategoriesListController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  List<CategoriesModel> _categoriesList = [];

  String? get errorMessage => _errorMessage;

  List<CategoriesModel> get categories => _categoriesList;

  bool get inProgress => _inProgress;

  Future<bool> getCategoriesList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(url: Url.categoriesListUrl);
    if (response.isSuccess) {
      _errorMessage = null;
      _categoriesList =
          CategoriesListModel.fromJson(response.responseData).categoriesList ??
              [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
