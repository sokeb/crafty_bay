import 'package:crafty_bay_app/presentation/ui/screen/unauthorized_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holder/auth_controller/auth_controller.dart';
import '../../state_holder/auth_controller/create_profile_controller.dart';
import '../../state_holder/auth_controller/read_profile_controller.dart';
import '../widgets/snack_bar_message.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key, required this.profileController});

  final ReadProfileController profileController;

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shipAddressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.profileController.userModel!.cusName ?? '';
    _shipAddressController.text =
        widget.profileController.userModel!.shipAdd ?? '';
    _phoneController.text = widget.profileController.userModel!.cusPhone ?? '';
    _addressController.text = widget.profileController.userModel!.cusAdd ?? '';
    _cityController.text = widget.profileController.userModel!.cusCity ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildTextField(
                        label: "Name",
                        controller: _nameController,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        icon: Icons.phone,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        label: 'City',
                        controller: _cityController,
                        icon: Icons.location_city_rounded,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        label: 'Address',
                        controller: _addressController,
                        icon: Icons.location_on,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        label: 'Shipping Address',
                        controller: _shipAddressController,
                        icon: Icons.local_shipping_sharp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: GetBuilder<CreateProfileController>(builder: (context) {
                return Visibility(
                  visible: !context.inProgress,
                  replacement: const LoadingIndicator(),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        updateProfile(widget.profileController);
                      },
                      child: const Text('Update Information')),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Future<void> updateProfile(ReadProfileController controller) async {
    AuthController authController = Get.find<AuthController>();
    if (controller.userModel!.cusName! == _nameController.text &&
        controller.userModel!.cusPhone! == _phoneController.text &&
        controller.userModel!.cusAdd! == _addressController.text &&
        controller.userModel!.cusCity! == _cityController.text &&
        controller.userModel!.shipAdd! == _shipAddressController.text &&
        mounted) {
      showSnackBar(
        context,
        "You haven't change any information",
      );
      return;
    }
    if (await authController.isLoggedInUser()) {
      bool isUpdated = await Get.find<CreateProfileController>().createProfile(
        firstName: _nameController.text,
        lastName: '',
        mobile: _phoneController.text,
        city: controller.userModel!.cusCity!,
        address: _addressController.text,
        postcode: controller.userModel!.cusPostcode!,
        country: controller.userModel!.cusCountry!,
        shippingAddress: _shipAddressController.text,
        token: authController.token,
      );
      if (isUpdated && mounted) {
        showSnackBar(context, 'Profile Data Updated', true);
        await Get.find<ReadProfileController>()
            .getProfileData(authController.token);
        Get.back();
        return;
      } else {
        if (mounted) {
          showSnackBar(
              context, Get.find<CreateProfileController>().errorMessage!);
          return;
        }
      }
    } else {
      if (mounted) {
        Get.to(() => const UnauthorizedScreen());
      }
    }
  }
}
