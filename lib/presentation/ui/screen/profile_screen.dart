import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/read_profile_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/profile_update_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/unauthorized_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/assets_path.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  ProfileInfoScreenState createState() => ProfileInfoScreenState();
}

class ProfileInfoScreenState extends State<ProfileInfoScreen> {



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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
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
                              Get.to(()=> ProfileUpdateScreen(profileController: profileController));
                            },
                            child: const Text('Update'),
                          ),
                        ),

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
                        )
                      ],
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


  Future<void> getProfileData() async {
    AuthController authController = Get.find<AuthController>();
    if (await authController.isLoggedInUser()) {
      await Get.find<ReadProfileController>()
          .getProfileData(authController.token);
      return;
    }
    return;
  }


  Future<void> onPressLogOut() async {
    AuthController authController = Get.find<AuthController>();
    await authController.logout();
    bool isLoggedIn = await authController.isLoggedInUser();
    if (!isLoggedIn && mounted) {
      showSnackBar(context, 'LogOut');
    }
    return;
  }
}
