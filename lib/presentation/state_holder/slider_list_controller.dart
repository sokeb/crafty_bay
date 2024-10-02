import 'package:get/get.dart';
import '../../data/models/home_page_slider_list_model.dart';
import '../../data/models/home_page_slider_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/url.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  List<SliderModel> _sliderList = [];

  String? get errorMessage => _errorMessage;

  List<SliderModel> get sliders => _sliderList;

  bool get inProgress => _inProgress;

  Future<bool> getSliderList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(url: Url.sliderListUrl);
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _sliderList =
          SliderListModel.fromJson(response.responseData).sliderList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
