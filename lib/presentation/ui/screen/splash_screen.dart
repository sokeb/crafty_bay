import 'package:crafty_bay_app/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future<void> _moveToTheNextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const MainBottomNavScreen());
    // Get.off(() => const EmailVerificationScreen());
  }

  @override
  void initState() {
    super.initState();
    _moveToTheNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogoWidget(),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Text(
                'version 2.1.1',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

