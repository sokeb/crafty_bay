import 'categories_model.dart';

class CategoriesListModel {
  String? msg;
  List<CategoriesModel>? categoriesList;

  CategoriesListModel({this.msg, this.categoriesList});

  CategoriesListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      categoriesList = <CategoriesModel>[];
      json['data'].forEach((v) {
        categoriesList!.add(CategoriesModel.fromJson(v));
      });
    }
  }
}

