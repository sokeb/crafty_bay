import 'package:crafty_bay_app/presentation/ui/screen/unauthorized_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/alternative_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../widgets/snack_bar_message.dart';
import '../../state_holder/auth_controller/auth_controller.dart';
import '../../state_holder/bottom_navbar_controller.dart';
import '../../state_holder/wish_product_list_controller.dart';
import '../widgets/loading_widget.dart';
import '../widgets/wish_product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    // getWishProductList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (value, __) {
        Get.find<BottomNavbarController>().selectHome();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.find<BottomNavbarController>().selectHome();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('Wish List'),
        ),
        body: GetBuilder<WishProductListController>(
            builder: (wishProductListController) {
          if (Get.find<AuthController>().token.isEmpty) {
            return const UnauthorizedScreen();
          } else if (wishProductListController.inProgress) {
            return const LoadingIndicator();
          } else if (wishProductListController.wishProductList.isEmpty) {
            return AlternativeView(
                title: 'Empty Wish LIst',
                content: Align(
                  alignment: const Alignment(1.5, 1),
                  child: SizedBox(
                      height: 200,
                      child: Lottie.asset("assets/lottie's/lottie1.json")),
                ));
          } else if (wishProductListController.errorMessage != null) {
            return Center(
              child: Text(wishProductListController.errorMessage ?? ''),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: wishProductListController.wishProductList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 0.1),
                itemBuilder: (context, product) {
                  return FittedBox(
                    child: WishProductCard(
                      productData:
                          wishProductListController.wishProductList[product],
                    ),
                  );
                }),
          );
        }),
      ),
    );
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
