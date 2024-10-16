import 'package:get/get.dart';
import '../screen/email_verification_screen.dart';
import '../utils/app_color.dart';

showUnauthorizedDialog() {
  Get.defaultDialog(
    title: 'Unauthorized Access',
    middleText:
        'You are not authorized to access this feature. Please login to continue.',
    textConfirm: 'Login',
    buttonColor: AppColors.themeColor,
    textCancel: 'Cancel',
    onConfirm: () {
      Get.back(); // Dismiss the dialog
      Get.to(
          () => const EmailVerificationScreen()); // Navigate to the login page
    },
  );
}
