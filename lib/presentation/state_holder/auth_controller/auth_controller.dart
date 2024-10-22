import 'dart:convert';

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
}
