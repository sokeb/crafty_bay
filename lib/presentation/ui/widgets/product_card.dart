import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:crafty_bay_app/presentation/state_holder/create_wish_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/wish_product_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/products_details_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/show_unauthorized_dialog.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_string.dart';
import '../../state_holder/auth_controller/auth_controller.dart';
import '../../state_holder/delete_wish_list_controller.dart';
import '../utils/app_color.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.products,
  });

  final ProductModel products;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        width: 120,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ProductsDetailsScreen(
                      productId: widget.products.id!,
                    ));
              },
              child: Container(
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: AppColors.themeColor.withOpacity(0.1),
                    image: DecorationImage(
                        image: NetworkImage(widget.products.image ?? AppString.nullValue),
                        fit: BoxFit.fill)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.products.title ?? AppString.nullValue,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black45),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${widget.products.price}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.themeColor,
                              fontSize: 12)),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          Text("${widget.products.star}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45,
                                  fontSize: 12))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        width: 35,
                        child: GetBuilder<WishProductListController>(
                            builder: (wishController) {
                          return IconButton(
                              onPressed: () {
                                addToFavorite(
                                    widget.products.id!, wishController);
                              },
                              icon: Center(
                                child: Icon(wishController.wishesIdList
                                    .contains(widget.products.id!)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                  color: AppColors.themeColor,
                                  size: 16,
                                ),
                              ));
                        }),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
        wishController.removeProduct(productId);
        await Get.find<DeleteWishListController>()
            .deleteWishlist(productId, authController.token);
        await wishController.getWishProductList(authController.token);
        return;
      }
      wishController.addProduct(productId);
      bool isAdded = await Get.find<CreateWishListController>()
          .createWishlist(productId, authController.token);

      await wishController.getWishProductList(authController.token);
      if (isAdded && mounted) {
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


