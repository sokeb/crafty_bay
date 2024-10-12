import 'dart:async';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/email_verification_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/otp_verification_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/read_profile_controller.dart';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../utils/regX.dart';
import '../../../utils/snack_bar_message.dart';
import '../../state_holder/auth_controller/countdown_timer.dart';
import 'complete_profile_screen.dart';
import 'main_bottom_nav_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool invalidOTP = false;
  late Timer countDownTimer;
  late final TextEditingController _otpTEController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OtpVerificationController otpController =
  Get.find<OtpVerificationController>();
  final ReadProfileController readProfileController =
  Get.find<ReadProfileController>();

  @override
  void initState() {
    _otpTEController = TextEditingController();
    super.initState();
    initiateTimer();
  }

  void initiateTimer() {
    Get.find<CountdownTimer>().resetTime();
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (countdown) {
      if (Get.find<CountdownTimer>().timeLeft < 1) {
        countdown.cancel();
        return;
      }
      Get.find<CountdownTimer>().decreaseTime();
    });
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
                Form(
                  key: _formKey,
                  child: PinCodeTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (otp) {
                      if (otp == null || otp.isEmpty) {
                        return 'OTP not given';
                      }
                      if (!RegEx.digitRegEx.hasMatch(otp)) {
                        return 'Wrong! Otp must be 6 Digit ';
                      }
                      return null;
                    },
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
                ),
                Text(invalidOTP ? "Invalid OTP" : ''),
                const SizedBox(height: 16),
                GetBuilder<CountdownTimer>(builder: (timer) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _onTapNextButton();
                          }
                        },
                        child: const Text('Next'),
                      ),
                      const SizedBox(height: 16),
                      timer.timeLeft == 0
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
                                    text: '${timer.timeLeft} s',
                                    style: const TextStyle(
                                        color: AppColors.themeColor))
                              ])),
                      const SizedBox(height: 16),
                      timer.timeLeft == 0
                          ? TextButton(
                          onPressed: () async {
                            initiateTimer();
                            bool res = await Get.find<
                                EmailVerificationController>()
                                .verifyEmail(widget.email);
                            if (res) {
                              initiateTimer();
                            }
                          },
                          child: const Text(
                            'Resent Code',
                            style: TextStyle(color: AppColors.themeColor),
                          ))
                          : const Text('Resent Code',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() async {
    if (Get.find<CountdownTimer>().timeLeft == 0) {
      showSnackBar(context, "Invalid OTP! This OTP is Expired");
      return;
    }
    bool isOtpValid =
    await otpController.verifyOtp(widget.email, _otpTEController.text);

    if (isOtpValid && mounted) {
      final bool isProfile = await readProfileController
          .getProfileData(Get.find<AuthController>().token);

      if (mounted && isProfile) {
        if (mounted && await Get.find<AuthController>().isProfileCompleted()) {
          Get.offAll(() => const MainBottomNavScreen());
          return;
          //Get.back();
        } else {
          if (mounted) {
            Get.to(() => const CompleteProfileScreen());
            return;
          }
        }
      } else {
        if (mounted) {
          showSnackBar(context, readProfileController.errorMessage!, true);
          return;
        }
      }
    } else {
      if (mounted) {
        showSnackBar(context, otpController.errorMessage!, true);
        return;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    countDownTimer.cancel();
  }
}
