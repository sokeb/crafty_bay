import 'package:crafty_bay_app/data/models/product_model.dart';

class ProductsListModel {
  String? msg;
  List<ProductModel>? productList;

  ProductsListModel({this.msg, this.productList});

  ProductsListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productList = <ProductModel>[];
      json['data'].forEach((v) {
        productList!.add(ProductModel.fromJson(v));
      });
    }
  }
}




