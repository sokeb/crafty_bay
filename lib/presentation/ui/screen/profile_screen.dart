import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/auth_controller/read_profile_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/bottom_navbar_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/cart_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/wish_product_list_controller.dart';
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
        title: const Text('Profile'),
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
          color: Colors.black.withOpacity(0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              backgroundImage: AssetImage(
                                AssetsPath.person,
                              ),
                              // Profile image
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController.userModel!.cusName ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    profileController.userModel!.user!.email ??
                                        '',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                    "${profileController.userModel!.cusCity ?? ''}, ${profileController.userModel!.cusCountry ?? ''} ",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            buildProductDetails(
                                Get.find<WishProductListController>()
                                    .wishProductList
                                    .length,
                                'wish item',
                                Icons.card_giftcard, () {
                              Get.back();
                              Get.find<BottomNavbarController>().changeIndex(3);
                            }),
                            buildProductDetails(
                                Get.find<CartListController>().cartList.length,
                                'item on your bucket',
                                Icons.shopping_cart, () {
                              Get.back();
                              Get.find<BottomNavbarController>().changeIndex(2);
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.themeColor)),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => ProfileUpdateScreen(
                                      profileController: profileController));
                                },
                                child: const Text("Edit"))
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                detailsSection(
                                    context,
                                    profileController,
                                    Icons.call,
                                    profileController.userModel!.cusPhone ?? '',
                                    'Mobile'),
                                detailsSection(
                                    context,
                                    profileController,
                                    Icons.local_shipping,
                                    profileController.userModel!.shipAdd ?? '',
                                    'Shipping Address'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
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

  Widget buildProductDetails(
      int num, String title, IconData icon, Function onTap) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              onTap();
            },
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.themeColor,
                ),
                const SizedBox(width: 5),
                Text(
                  '$num $title',
                  style: const TextStyle(color: AppColors.themeColor),
                )
              ],
            ))
      ],
    );
  }

  Widget detailsSection(
      BuildContext context,
      ReadProfileController profileController,
      IconData icon,
      String title,
      String sub) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.black,
      ),
      title: Text(title,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
      subtitle: Text(sub),
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
