import 'package:crafty_bay_app/data/models/product_data_model.dart';

class ProductDetailsModel {
  String? msg;
  List<ProductDataModel>? data;

  ProductDetailsModel({this.msg, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ProductDataModel>[];
      json['data'].forEach((v) {
        data!.add(ProductDataModel.fromJson(v));
      });
    }
  }
}
