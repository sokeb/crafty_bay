import 'dart:async';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'complete_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool invalidOTP = false;
  int resentTimer = 10;
  late Timer countDownTimer;
  final TextEditingController _otpTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resentTimer = resentTimer - 1;
      });
      if (resentTimer < 1) {
        countDownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countDownTimer.isActive) {
      countDownTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogoWidget(),
                const SizedBox(height: 15),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text('A 4 digit OTP code has been sent',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 16),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: AppColors.themeColor),
                  animationDuration: const Duration(milliseconds: 300),
                  controller: _otpTEController,
                  appContext: context,
                ),
                Text(invalidOTP ? "Invalid OTP" : ''),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    String otp = '111111';
                    if (_otpTEController.text == otp) {
                      setState(() {
                        invalidOTP = false;
                      });
                      stopTimer();
                      _onTapNextButton();
                    }else {
                      setState(() {
                        invalidOTP = true;
                      });
                    }
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(height: 16),
                resentTimer == 0
                    ? const Text(
                        'Your OTP Code is Expired',
                        style: TextStyle(color: Colors.red),
                      )
                    : RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            text: 'This Code Will Expire in ',
                            children: [
                            TextSpan(
                                text: '$resentTimer s',
                                style: const TextStyle(
                                    color: AppColors.themeColor))
                          ])),
                const SizedBox(height: 16),
                resentTimer == 0
                    ? TextButton(
                        onPressed: () {
                          resentTimer = 10;
                          startTimer();
                        },
                        child: const Text(
                          'Resent Code',
                          style: TextStyle(color: AppColors.themeColor),
                        ))
                    : const Text('Resent Code',
                        style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() {
    Get.off(() => const CompleteProfileScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _otpTEController.dispose();
  }
}
