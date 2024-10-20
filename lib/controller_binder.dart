import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/countdown_timer.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/create_profile_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/email_verification_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/otp_verification_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/read_profile_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/bottom_navbar_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/cart_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/categories_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/create_cart_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/create_product_review_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/create_wish_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/delete_wish_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/new_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/payment_method_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_list_by_category_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_details_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_review_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/slider_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/special_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/web_view_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/wish_product_list_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavbarController());
    Get.put(Logger());
    Get.put(NetworkCaller(logger: Get.find<Logger>()));
    Get.put(SliderListController());
    Get.put(CategoriesListController());
    Get.put(NewProductListController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(AuthController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(CountdownTimer());
    Get.put(ReadProfileController());
    Get.put(CreateProfileController());
    Get.put(CartListController());
    Get.put(CreateCartListController());
    Get.put(ProductReviewController());
    Get.put(CreateProductReviewController());
    Get.put(WishProductListController());
    Get.put(CreateWishListController());
    Get.put(DeleteWishListController());
    Get.put(PaymentMethodController());
    Get.put(PaymentWebViewController());
  }
}