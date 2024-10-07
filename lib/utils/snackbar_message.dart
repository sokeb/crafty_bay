import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: !isError ? Colors.red : AppColors.themeColor,
    ),
  );
}
