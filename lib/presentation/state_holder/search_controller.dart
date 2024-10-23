import 'package:crafty_bay_app/presentation/state_holder/new_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/popular_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/special_product_list_controller.dart';
import 'package:get/get.dart';

import '../../data/models/product_model.dart';

class SearchProductController extends GetxController{

  final List<ProductModel> _allProducts = [];

  List<ProductModel> get allProducts => _allProducts;

  void getAllProductData(){
    _allProducts.addAll(Get.find<PopularProductListController>().popularProductList);
    _allProducts.addAll(Get.find<SpecialProductListController>().specialProductList);
    _allProducts.addAll(Get.find<NewProductListController>().newProductList);
    update();
  }

}