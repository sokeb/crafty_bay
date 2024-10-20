import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/cart_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/payment_method_screen/select_payment_method_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/unauthorized_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:crafty_bay_app/utils/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../state_holder/bottom_navbar_controller.dart';
import '../widgets/cart_list_widget/alternative_view.dart';
import '../widgets/cart_list_widget/cart_list_product_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, __) {
        Get.find<BottomNavbarController>().selectHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.find<BottomNavbarController>().selectHome();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('Cart'),
        ),
        body: GetBuilder<CartListController>(builder: (cartListController) {
          if (Get.find<AuthController>().token.isEmpty) {
            return const UnauthorizedScreen();
          } else if (cartListController.inProgress) {
            return const LoadingIndicator();
          } else if (cartListController.cartList.isEmpty) {
            return AlternativeView(
              title: 'Empty Cart List',
              content: Align(
                alignment: const Alignment(1.5, 1),
                child: SizedBox(
                    height: 200,
                    child: Lottie.asset("assets/lottie's/lottie1.json")),
              ),
            );
          } else if (cartListController.errorMessage != null) {
            return Center(
              child: Text(cartListController.errorMessage ?? ''),
            );
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: cartListController.cartList.length,
                      itemBuilder: (context, int product) {
                        return CartListProductCard(
                          cartProduct: cartListController.cartList[product],
                        );
                      },
                    )),
              ),
              buildTotalPriceAndCheckoutSection(cartListController)
            ],
          );
        }),
      ),
    );
  }

  Widget buildTotalPriceAndCheckoutSection(
      CartListController cartListController) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54)),
                const SizedBox(
                  height: 2,
                ),
                Text('\$${cartListController.totalBill}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.themeColor))
              ],
            ),
            SizedBox(
              width: 130,
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const PaymentMethodScreen());
                  },
                  child: const Text('Checkout')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getCartList() async {
    AuthController authController = Get.find<AuthController>();
    CartListController cartListController = Get.find<CartListController>();
    if (await authController.isLoggedInUser() == false) {
      authController.setToken = "";
      authController.update();
      return;
    }
    if (cartListController.cartList.isNotEmpty) {
      await cartListController.getCartProductList(authController.token);
      return;
    }
    if (authController.token.isEmpty) {
      return;
    }
    bool status =
        await cartListController.getCartProductList(authController.token);
    if (mounted && !status) {
      showSnackBar(context, cartListController.errorMessage!);
    }
  }
}
