import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration:const Duration(seconds: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: !isError ? Colors.red : AppColors.themeColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    ),
  );
}
