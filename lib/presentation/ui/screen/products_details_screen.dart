import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/cart_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/create_cart_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_details_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/complete_profile_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/email_verification_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/details_page_widgets/details_page_slider.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/details_page_widgets/built_size_select_section.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../utils/assets_path.dart';
import '../widgets/snack_bar_message.dart';
import '../utils/app_color.dart';
import '../widgets/details_page_widgets/built_color_select_section.dart';
import '../widgets/details_page_widgets/name_review_quantity_section.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  String _selectedColor = '';
  String _selectedSize = '';
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>()
        .getProductDetailsList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.inProgress) {
          return const LoadingIndicator();
        }
        if (productDetailsController.errorMessage != null) {
          return Center(
            child: Text(productDetailsController.errorMessage!),
          );
        }
        if (productDetailsController.data!.isEmpty) {
          return const Center(
            child: Text('Product details are not available'),
          );
        }
        List<String> colors =
            productDetailsController.data![0].color!.split(',');
        List<String> sizes = productDetailsController.data![0].size!.split(',');
        _selectedColor = colors.first;
        _selectedSize = sizes.first;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DetailsPageSlider(
                      sliderImgUrls: [
                        productDetailsController.data![0].img1!,
                        productDetailsController.data![0].img2!,
                        productDetailsController.data![0].img3!,
                        productDetailsController.data![0].img4!,
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuiltNameQuantityReviewSection(
                            productDetails: productDetailsController.data![0],
                            quantity: (quantity) {
                              _quantity = quantity;
                            },
                          ),
                          BuiltColorSelectSection(
                            onSelectedColor: (color) {
                              _selectedColor = color;
                            },
                            color: colors,
                          ),
                          const SizedBox(height: 8),
                          BuiltSizeSelectSection(
                            sizes: sizes,
                            onSelectedSize: (size) {
                              _selectedSize = size;
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text('Description',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 8),
                          Text(
                              productDetailsController
                                  .data![0].product!.shortDes!,
                              style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildTotalPriceAndAddToCartSection(
                productDetailsController.data![0].product!.price!)
          ],
        );
      }),
    );
  }

  Widget buildTotalPriceAndAddToCartSection(String price) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54)),
                const SizedBox(
                  height: 2,
                ),
                Text('\$ $price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.themeColor)),
              ],
            ),
            SizedBox(
              width: 130,
              child:
                  GetBuilder<CartListController>(builder: (cartListController) {
                if (Get.find<AuthController>().token.isNotEmpty) {
                  Get.find<CartListController>()
                      .getCartProductList(Get.find<AuthController>().token);
                }
                if (cartListController.idList.contains(widget.productId)) {
                  return SvgPicture.asset(
                    AssetsPath.addedCart,
                    width: 50,
                  );
                }
                return ElevatedButton(
                  onPressed: _onTapAddToCard,
                  child: const Text('Add To Cart'),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void _onTapAddToCard() async {
    AuthController authController = Get.find<AuthController>();
    bool isLoggedIn = await authController.isLoggedInUser();
    if (isLoggedIn) {
      bool isProfileCompleted = await authController.isProfileCompleted();
      if (isProfileCompleted) {
        bool isAddedToCartList = await Get.find<CreateCartListController>()
            .createCartList(
                productId: widget.productId,
                color: _selectedColor,
                size: _selectedSize,
                qty: _quantity,
                token: authController.token);
        if (isAddedToCartList) {
          if (mounted) {
            //showSnackBar(context, 'Product added to the cart list', true);
            return;
          }
        } else {
          if (mounted) {
            showSnackBar(
                context, Get.find<CreateCartListController>().errorMessage!);
            return;
          }
        }
      } else {
        if (mounted) {
          showSnackBar(context,
              'Your Profile Is not Completed! Please Complete Your Profile to Continue');
          Get.to(() => const CompleteProfileScreen());
          return;
        }
      }
    } else {
      if (mounted) {
        Get.to(() => const EmailVerificationScreen());
        return;
      }
    }
  }
}
