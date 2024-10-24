import 'package:crafty_bay_app/utils/app_string.dart';
import 'package:get/get.dart';
import '../screen/email_verification_screen.dart';
import '../utils/app_color.dart';

showUnauthorizedDialog() {
  Get.defaultDialog(
    title: AppString.unauthorizedAccess,
    middleText:
        AppString.unauthorizedMessage,
    textConfirm: AppString.logIn,
    buttonColor: AppColors.themeColor,
    textCancel: AppString.cancel,
    onConfirm: () {
      Get.back(); // Dismiss the dialog
      Get.to(
          () => const EmailVerificationScreen()); // Navigate to the login page
    },
  );
}
