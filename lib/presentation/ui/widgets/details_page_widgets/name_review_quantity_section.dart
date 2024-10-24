import 'package:crafty_bay_app/data/models/product_data_model.dart';
import 'package:crafty_bay_app/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import '../snack_bar_message.dart';
import '../../../state_holder/auth_controller/auth_controller.dart';
import '../../../state_holder/create_wish_list_controller.dart';
import '../../../state_holder/delete_wish_list_controller.dart';
import '../../../state_holder/wish_product_list_controller.dart';
import '../../screen/reviews_screen.dart';
import '../../utils/app_color.dart';
import '../show_unauthorized_dialog.dart';

class BuiltNameQuantityReviewSection extends StatefulWidget {
  const BuiltNameQuantityReviewSection({
    super.key,
    required this.productDetails,
    required this.quantity,
  });

  final ProductDataModel productDetails;
  final Function(int) quantity;

  @override
  State<BuiltNameQuantityReviewSection> createState() =>
      _BuiltNameQuantityReviewSectionState();
}

class _BuiltNameQuantityReviewSectionState
    extends State<BuiltNameQuantityReviewSection> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Wrap(
                children: [
                  Text(widget.productDetails.product!.title!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ],
              )),
              ItemCount(
                color: AppColors.themeColor,
                initialValue: _quantity,
                minValue: 1,
                maxValue: 5,
                decimalPlaces: 0,
                onChanged: (value) {
                  _quantity = value.toInt();
                  widget.quantity(value.toInt());
                  setState(() {});
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  Text(' ${widget.productDetails.product!.star!}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                          fontSize: 13))
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => ReviewsScreen(
                          productId: widget.productDetails.id!,
                        ));
                  },
                  child: const Text('Reviews',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                          fontSize: 15))),
              const SizedBox(
                width: 6,
              ),
              SizedBox(
                height: 30,
                width: 35,
                child: GetBuilder<WishProductListController>(
                    builder: (wishController) {
                  return IconButton(
                      onPressed: () {
                        addToFavorite(
                            widget.productDetails.id!, wishController);
                      },
                      icon: Center(
                        child: Icon(
                          wishController.wishesIdList
                                  .contains(widget.productDetails.id!)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: AppColors.themeColor,
                          size: 20,
                        ),
                      ));
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> addToFavorite(
      int productId, WishProductListController wishController) async {
    AuthController authController = Get.find<AuthController>();
    final isLoggedIn = await authController.isLoggedInUser();
    if (!isLoggedIn) {
      showUnauthorizedDialog();
      return;
    }
    if (isLoggedIn) {
      if (wishController.wishesIdList.contains(productId) && mounted) {
        await Get.find<DeleteWishListController>()
            .deleteWishlist(productId, authController.token);
        await wishController.getWishProductList(authController.token);
        return;
      }
      bool isAdded = await Get.find<CreateWishListController>()
          .createWishlist(productId, authController.token);

      await wishController.getWishProductList(authController.token);
      if (isAdded && mounted) {
        showSnackBar(context, AppString.addWishlistMessage, true);
        return;
      } else {
        if (mounted) {
          showSnackBar(
            context,
            Get.find<CreateWishListController>().errorMessage!,
          );
        }
        return;
      }
    }
  }
}
