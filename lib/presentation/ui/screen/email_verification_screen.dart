import 'package:crafty_bay_app/presentation/state_holder/auth_controller/email_verification_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/regX.dart';
import '../../../utils/snack_bar_message.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogoWidget(),
                  const SizedBox(height: 15),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text('Please Enter Your Email Address',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey)),
                  const SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (RegEx.emailRegEx.hasMatch(value!)) {
                        return null;
                      }
                      return 'Enter Your Valid Email!';
                    },
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _onTapNextButton(_emailTEController.text.trim());
                    },
                    child: const Text('Next'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextButton(String email) async {
    if (_formKey.currentState!.validate()) {
      EmailVerificationController response =
          Get.find<EmailVerificationController>();
      bool result = await response.verifyEmail(email);
      if (mounted && result) {
        Get.off(() => OtpVerificationScreen(email: email,));
        if (mounted) {
          showSnackBar(context, response.data!, true);
        }
        return;
      } else {
        if (mounted) {
          showSnackBar(context, response.errorMessage!);
          return;
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
