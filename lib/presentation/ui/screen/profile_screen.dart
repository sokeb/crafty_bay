import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/create_profile_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/read_profile_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/unauthorized_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/assets_path.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  ProfileInfoScreenState createState() => ProfileInfoScreenState();
}

class ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _shipAddressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
      getProfileData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
      ),
      body: GetBuilder<ReadProfileController>(builder: (profileController) {
        if (Get.find<AuthController>().token == '') {
          return const UnauthorizedScreen();
        }
        if (profileController.inProgress) {
          return const Center(child: LoadingIndicator());
        }
        if (profileController.errorMessage != null) {
          return Center(
            child: Text(profileController.errorMessage!),
          );
        }

        if (profileController.userModel == null) {
          return const Center(child: UnauthorizedScreen());
        }

        _firstNameController.text = profileController.userModel!.cusName ?? '';
        _shipAddressController.text =
            profileController.userModel!.shipAdd ?? '';
        _phoneController.text = profileController.userModel!.cusPhone ?? '';
        _addressController.text = profileController.userModel!.cusAdd ?? '';

        return Container(
          color: AppColors.themeColor.withOpacity(0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: AssetImage(
                            AssetsPath.person,
                          ),
                          // Profile image
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                                size: 16,
                              ),
                              onPressed: () {
                                // Open camera/gallery to change profile pic
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileController.userModel!.cusName ?? '',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(profileController.userModel!.user!.email ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildTextField(
                              label: "first name",
                              controller: _firstNameController,
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
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                onPressed: () {
                                  updateProfile(profileController);
                                },
                                child: const Text('Update Information'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: () {
                                  onPressLogOut();
                                },
                                child: const Text('Logout'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
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

  Future<void> getProfileData() async {
    AuthController authController = Get.find<AuthController>();
    if (await authController.isLoggedInUser()) {
      await Get.find<ReadProfileController>()
          .getProfileData(authController.token);
      return;
    }
    return;
  }

  Future<void> updateProfile(ReadProfileController controller) async {
    AuthController authController = Get.find<AuthController>();
    if (await authController.isLoggedInUser()) {
      bool isUpdated = await Get.find<CreateProfileController>().createProfile(
        firstName: _firstNameController.text,
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
        getProfileData();
        showSnackBar(context, 'Profile Data Updated', true);
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

  Future<void> onPressLogOut() async {
    AuthController authController = Get.find<AuthController>();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString("token", '');
    bool isLoggedIn = await authController.isLoggedInUser();
    if(!isLoggedIn && mounted){
      Get.find<ReadProfileController>().clearData();
      showSnackBar(context, 'LogOut');
    }
    return;
  }
}
