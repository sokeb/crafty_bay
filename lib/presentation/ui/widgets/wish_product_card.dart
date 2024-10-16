import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/delete_wish_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/wish_product_list_controller.dart';
import 'package:crafty_bay_app/utils/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/wish_product_model.dart';
import '../screen/products_details_screen.dart';
import '../utils/app_color.dart';
import '../utils/assets_path.dart';

class WishProductCard extends StatefulWidget {
  const WishProductCard({
    super.key,
    required this.productData,
  });

  final WishProductData productData;

  @override
  State<WishProductCard> createState() => _WishProductCardState();
}

class _WishProductCardState extends State<WishProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ProductsDetailsScreen(
                    productId: widget.productData.productId!));
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
                    image: const DecorationImage(
                      image: AssetImage(AssetsPath.shoe1),
                      fit: BoxFit.scaleDown,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productData.product!.title!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black45),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${widget.productData.product!.price!}',
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
                          Text("${widget.productData.product!.star}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45,
                                  fontSize: 12))
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          deleteWishProduct(widget.productData.productId!);
                        },
                        child: Card(
                          color: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
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

  Future<void> deleteWishProduct(int productId) async {
    AuthController authController = Get.find<AuthController>();
    DeleteWishListController deleteController =
        Get.find<DeleteWishListController>();

    bool isDeleted =
        await deleteController.deleteWishlist(productId, authController.token);

    if (mounted && isDeleted) {
      showSnackBar(context, 'Product deleted from wish list', true);
      await Get.find<WishProductListController>()
          .getWishProductList(authController.token);
    } else {
      if (mounted) {
        showSnackBar(context, deleteController.errorMessage!);
        return;
      }
    }
  }
}
