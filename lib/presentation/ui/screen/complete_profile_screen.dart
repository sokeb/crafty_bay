import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/create_profile_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/regx.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();

  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

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
                  'Complete Profile',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text('Gets started with us with your details ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _firstNameTEController,
                        decoration:
                            const InputDecoration(hintText: 'First Name'),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_lastNameFocusNode);
                        },
                        validator: (firstName) {
                          if (firstName == null || firstName.isEmpty) {
                            return 'This flied is require';
                          }
                          if (!RegEx.alphabetRegEx.hasMatch(firstName)) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        focusNode: _lastNameFocusNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _lastNameTEController,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_mobileFocusNode);
                        },
                        validator: (lastName) {
                          if (lastName == null || lastName.isEmpty) {
                            return 'This flied is require';
                          }
                          if (!RegEx.alphabetRegEx.hasMatch(lastName)) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        focusNode: _mobileFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: _mobileTEController,
                        decoration:
                            const InputDecoration(hintText: 'Mobile Number'),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_cityFocusNode);
                        },
                        validator: (mobile) {
                          if (mobile == null || mobile.isEmpty) {
                            return 'This flied is require';
                          }
                          if (!RegEx.mobileRegEx.hasMatch(mobile)) {
                            return 'Invalid Mobile Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        focusNode: _cityFocusNode,
                        textInputAction: TextInputAction.next,
                        controller: _cityTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(hintText: 'City'),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_addressFocusNode);
                        },
                        validator: (city) {
                          if (city == null || city.isEmpty) {
                            return "This Field is required";
                          }
                          if (!RegEx.alphabetRegEx.hasMatch(city)) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        focusNode: _addressFocusNode,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        controller: _addressTEController,
                        decoration:
                            const InputDecoration(hintText: 'Shipping Address'),
                        validator: (address) {
                          if (address == null || address.isEmpty) {
                            return 'This flied is require';
                          }
                          if (!RegEx.addressRegEx.hasMatch(address)) {
                            return 'Enter valid Address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _onTapCompleteButton();
                    }
                  },
                  child: const Text('Complete'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapCompleteButton() async {
    bool result = await Get.find<CreateProfileController>().createProfile(
      firstName: _firstNameTEController.text,
      lastName: _lastNameTEController.text,
      mobile: _mobileTEController.text.trim(),
      city: _cityTEController.text,
      shippingAddress: _addressTEController.text,
      token: Get.find<AuthController>().token,
    );
    if (result) {
      Get.offAll(() => const MainBottomNavScreen());
    } else {
      if (mounted) {
        showSnackBar(
          context,
          Get.find<CreateProfileController>().errorMessage!,
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _addressTEController.dispose();
    _lastNameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _cityFocusNode.dispose();
    _addressFocusNode.dispose();
  }
}
