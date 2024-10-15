import 'package:crafty_bay_app/presentation/ui/screen/email_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/assets_path.dart';

class UnauthorizedScreen extends StatelessWidget {
  const UnauthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(AssetsPath.unauthorized),
            height: 200,
          ),
          const SizedBox(height: 10),
          const Text('Please LogIn to Continue'),
          const SizedBox(height: 10),
          SizedBox(
            width: 150,
            child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const EmailVerificationScreen());
                },
                child: const Text('Login')),
          )
        ],
      ),
    );
  }
}
