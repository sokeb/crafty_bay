import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppbarIconButtonWidget extends StatelessWidget {
  const AppbarIconButtonWidget({
    super.key, required this.onTap, required this.iconData,
  });

  final VoidCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.grey.shade100,
      child: Icon(
        iconData,
        color: AppColors.themeColor,
        size: 18,
      ),
    );
  }
}
