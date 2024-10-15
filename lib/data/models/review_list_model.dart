class ReviewListModel {
  String? msg;
  List<ReviewListData>? data;

  ReviewListModel({this.msg, this.data});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ReviewListData>[];
      json['data'].forEach((v) {
        data!.add(ReviewListData.fromJson(v));
      });
    }
  }
}

class ReviewListData {
  int? id;
  String? description;
  String? rating;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Profile? profile;

  ReviewListData(
      {this.id,
      this.description,
      this.rating,
      this.customerId,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.profile});

  ReviewListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    rating = json['rating'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
}

class Profile {
  int? id;
  String? cusName;

  Profile({this.id, this.cusName});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }
}
