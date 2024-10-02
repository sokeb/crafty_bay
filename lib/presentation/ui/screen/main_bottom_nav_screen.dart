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
    Get.find<SliderListController>().getSliderList();
    Get.find<CategoriesListController>().getCategoriesList();
    Get.find<PopularProductListController>().getPopularProductList();
    Get.find<NewProductListController>().getNewProductList();
    Get.find<SpecialProductListController>().getSpecialProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavbarController>(builder: (_) {
      return Scaffold(
        body: _screen[_navbarController.selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _navbarController.selectedIndex,
          onDestinationSelected: _navbarController.changeIndex,
          destinations:  const[
            NavigationDestination(icon: Icon(Icons.home, color: AppColors.themeColor), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'category'),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(
                icon: Icon(Icons.favorite_border), label: 'WishList'),
          ],
        ),
      );
    });
  }
}
