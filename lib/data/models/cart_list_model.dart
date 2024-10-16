import 'cart_product.dart';

class CartListModel {
  String? msg;
  List<CartDataModel>? cartData;

  CartListModel({this.msg, this.cartData});

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      cartData = <CartDataModel>[];
      json['data'].forEach((v) {
        cartData!.add(CartDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (cartData != null) {
      data['data'] = cartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartDataModel {
  int? id;
  int? userId;
  int? productId;
  String? color;
  String? size;
  String? qty;
  String? price;
  String? createdAt;
  String? updatedAt;
  CartProduct? productData;

  CartDataModel(
      {this.id,
      this.userId,
      this.productId,
      this.color,
      this.size,
      this.qty,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.productData});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productData =
        json['product'] != null ? CartProduct.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['color'] = color;
    data['size'] = size;
    data['qty'] = qty;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (productData != null) {
      data['product'] = productData!.toJson();
    }
    return data;
  }
}
