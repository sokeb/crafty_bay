import 'package:crafty_bay_app/controller_binder.dart';
import 'package:crafty_bay_app/presentation/ui/screen/splash_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
      theme: ThemeData(
          colorSchemeSeed: AppColors.themeColor,
          scaffoldBackgroundColor: Colors.white,
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: AppColors.themeColor),
          textTheme: const TextTheme(
              headlineLarge:
                  TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),

          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black
            )
          ),

          inputDecorationTheme: InputDecorationTheme(
              border: _outlineInputBorder(),
              enabledBorder: _outlineInputBorder(),
              disabledBorder: _outlineInputBorder(),
              errorBorder: _outlineInputBorder(Colors.red),
              focusedBorder: _outlineInputBorder(Colors.green),
              hintStyle: const TextStyle(fontWeight: FontWeight.w300),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),

          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8),
                  fixedSize: const Size.fromWidth(double.maxFinite)))),
    );
  }

  OutlineInputBorder _outlineInputBorder([Color? color]) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color ?? AppColors.themeColor, width: 1),
        borderRadius: BorderRadius.circular(8));
  }
}
