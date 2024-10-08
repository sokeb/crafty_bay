import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_details_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/complete_profile_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/email_verification_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/details_page_widgets/details_page_slider.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/details_page_widgets/built_size_select_section.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/snackbar_message.dart';
import '../utils/app_color.dart';
import '../widgets/details_page_widgets/built_color_select_section.dart';
import '../widgets/details_page_widgets/name_review_qunatity_section.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
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
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DetailsPageSlider(
                      sliderImgUrls: [
                        productDetailsController.productDetails!.img1!,
                        productDetailsController.productDetails!.img2!,
                        productDetailsController.productDetails!.img3!,
                        productDetailsController.productDetails!.img4!,
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuiltNameQuantityReviewSection(
                              productDetails:
                                  productDetailsController.productDetails!),
                          BuiltColorSelectSection(
                            onSelectedColor: (color) {},
                            color: productDetailsController
                                .productDetails!.color!
                                .split(','),
                          ),
                          const SizedBox(height: 8),
                          BuiltSizeSelectSection(
                            sizes: productDetailsController
                                .productDetails!.size!
                                .split(','),
                            onSelectedSize: (color) {},
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
                                  .productDetails!.product!.shortDes!,
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
                productDetailsController.productDetails!.product!.price!)
          ],
        );
      }),
    );
  }

  Widget buildTotalPriceAndAddToCartSection(String price) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.2),
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
                const Text('Total Price',
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
              child: ElevatedButton(
                onPressed: _onTapAddToCard,
                child: const Text('Add To Cart'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTapAddToCard() async {
    bool isLoggedIn = await Get.find<AuthController>().isLoggedInUser();
    if (isLoggedIn) {
      bool isProfileCompleted = await Get.find<AuthController>().isProfileCompleted();
      if(isProfileCompleted){
        //todo
      }else{
        if (mounted) {
          showSnackBar(context, 'Your Profile Is not Completed! Please Complete Your Profile to Continue');
        }
        Get.to(()=> const CompleteProfileScreen());
      }
    } else {
      Get.to(() => const EmailVerificationScreen());
    }
  }
}
