import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/cart_list_controller.dart';
import 'package:crafty_bay_app/utils/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import '../../../../data/models/cart_list_model.dart';
import '../../utils/app_color.dart';

class CartListProductCard extends StatefulWidget {
  const CartListProductCard({
    super.key,
    required this.cartProduct,
  });

  final CartDataModel cartProduct;

  @override
  State<CartListProductCard> createState() => _CartListProductCardState();
}

class _CartListProductCardState extends State<CartListProductCard> {
  CartListController cartListController = Get.find<CartListController>();

  // @override
  // void initState() {
  //   super.initState();
  //   cartListController.productQuantities[widget.cartProduct.productData!.id!] =
  //       int.parse(widget.cartProduct.qty!);
  // }

  @override
  Widget build(BuildContext context) {
    String productId = widget.cartProduct.productData!.id.toString();
    return Card(
      color: Colors.white,
      elevation: 1,
      child: SizedBox(
        height: 120,
        width: MediaQuery.sizeOf(context).width - 32,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              widget.cartProduct.productData!.image!),
                          fit: BoxFit.cover,
                        )))),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          Text(widget.cartProduct.productData!.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black54)),
                        ],
                      ),
                      Text(
                        'Color: ${widget.cartProduct.color}, '
                        'Size: ${widget.cartProduct.size}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${cartListController.totalProductPrice[productId]}',
                        style: const TextStyle(
                            color: AppColors.themeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            onPressDelete(productId);
                          },
                          icon: const Icon(Icons.delete_outline)),
                      FittedBox(
                          child: ItemCount(
                        color: AppColors.themeColor,
                        initialValue: cartListController.quantity[productId]!,
                        minValue: 1,
                        maxValue: 5,
                        decimalPlaces: 0,
                        onChanged: (value) {
                          int currentValue =
                              cartListController.quantity[productId]!;
                          if (currentValue > value) {
                            cartListController.updateCard(productId, false);
                            setState(() {});
                          }
                          if (currentValue < value) {
                            cartListController.updateCard(productId, true);
                            setState(() {});
                          }
                        },
                      )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> onPressDelete(String productId) async {
    bool result = await cartListController.deleteCartProductList(
        int.parse(productId), Get.find<AuthController>().token);
    if (result && mounted) {
      showSnackBar(context, "Product Deleted", true);
      await cartListController
          .getCartProductList(Get.find<AuthController>().token);
      return;
    } else {
      if (mounted) {
        showSnackBar(context, cartListController.errorMessage!);
      }
    }
  }
}
