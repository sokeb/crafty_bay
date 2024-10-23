import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/bottom_navbar_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/new_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/special_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/cart_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/category_list_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/home_page_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/wish_list_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holder/categories_list_controller.dart';
import '../../state_holder/slider_list_controller.dart';
import '../../state_holder/wish_product_list_controller.dart';
import '../widgets/snack_bar_message.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final BottomNavbarController _navbarController =
      Get.find<BottomNavbarController>();

  final List<Widget> _screen = const [
    HomePageScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SliderListController>().getSliderList();
      Get.find<CategoriesListController>().getCategoriesList();
      Get.find<PopularProductListController>().getPopularProductList();
      Get.find<NewProductListController>().getNewProductList();
      Get.find<SpecialProductListController>().getSpecialProductList();
      getWishProductList();
      checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavbarController>(builder: (_) {
      return Scaffold(
        body: _screen[_navbarController.selectedIndex],
        bottomNavigationBar: Container(
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
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: NavigationBar(
              height: 70,
              backgroundColor: Colors.white,
              selectedIndex: _navbarController.selectedIndex,
              onDestinationSelected: _navbarController.changeIndex,
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.home,
                        color: _navbarController.selectedIndex == 0
                            ? AppColors.themeColor
                            : Colors.black54),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.category,
                        color: _navbarController.selectedIndex == 1
                            ? AppColors.themeColor
                            : Colors.black54),
                    label: 'category'),
                NavigationDestination(
                    icon: Icon(Icons.shopping_cart,
                        color: _navbarController.selectedIndex == 2
                            ? AppColors.themeColor
                            : Colors.black54),
                    label: 'Cart'),
                NavigationDestination(
                  icon: Icon(Icons.favorite,
                      color: _navbarController.selectedIndex == 3
                          ? AppColors.themeColor
                          : Colors.black54),
                  label: 'WishList',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> checkAuth() async {
    AuthController authController = Get.find<AuthController>();
    if (await authController.isLoggedInUser()) {
      await Get.find<WishProductListController>()
          .getWishProductList(authController.token);
      return;
    }
    return;
  }

  Future<void> getWishProductList() async {
    AuthController authController = Get.find<AuthController>();
    WishProductListController wishListController =
        Get.find<WishProductListController>();

    if (await authController.isLoggedInUser() == false) {
      authController.setToken = "";
      authController.update();
      return;
    }

    if (wishListController.wishProductList.isNotEmpty) {
      await wishListController.getWishProductList(authController.token);
      return;
    }
    if (authController.token.isEmpty) {
      return;
    }
    bool status =
        await wishListController.getWishProductList(authController.token);
    if (mounted && !status) {
      showSnackBar(context, wishListController.errorMessage!);
    }
  }
}
