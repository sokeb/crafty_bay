import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/countdown_timer.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/create_profile_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/email_verification_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/otp_verification_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/read_profile_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/bottom_navbar_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/categories_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/new_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_list_by_category_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_details_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/slider_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/special_product_list_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavbarController());
    Get.put(Logger());
    Get.put(NetworkCaller(logger: Get.find<Logger>()));
    Get.put(SliderListController());
    Get.lazyPut(() => CategoriesListController());
    Get.lazyPut(() => NewProductListController());
    Get.lazyPut(() => PopularProductListController());
    Get.lazyPut(() => SpecialProductListController());
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(AuthController());
    Get.put(EmailVerificationController());
    Get.lazyPut(()=>OtpVerificationController());
    Get.lazyPut(()=>CountdownTimer());
    Get.lazyPut(()=>ReadProfileController());
    Get.lazyPut(()=>CreateProfileController());
  }
}