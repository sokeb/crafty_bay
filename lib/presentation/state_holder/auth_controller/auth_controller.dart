import 'dart:convert';

import 'package:crafty_bay_app/presentation/state_holder/auth_controller/read_profile_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/wish_product_list_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../data/models/user_model.dart';

class AuthController extends GetxController {
  String _token = "";

  String get token => _token;

  set setToken(String token) {
    _token = token;
  }

  late UserModel _userModel;

  UserModel get userModel => _userModel;

  set setUserData(UserModel userModel) {
    _userModel = userModel;
  }

  Future<bool> isLoggedInUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString("token");
    if (token!.isEmpty) {
      return false;
    }
    if (token == '' || JwtDecoder.isExpired(token)) {
      return false;
    }
    _token = token;
    return true;
  }

  Future<bool> isProfileCompleted() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool? hasUserData = localStorage.getBool("hasUserData");
    if (hasUserData == null || !hasUserData) {
      return false;
    }
    return true;
  }

  Future<void> saveUserData(
      UserModel userModel, SharedPreferences localStorage) async {
    localStorage.setString("userData", jsonEncode(userModel.toJson()));
    _userModel = userModel;
  }

  Future<void> logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    _token = "";
    //localStorage.setString("token", '');
    Get.find<ReadProfileController>().clearData();
    Get.find<WishProductListController>().clearList();
  }

}
