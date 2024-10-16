import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screen/create_review_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screen/email_verification_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holder/product_review_controller.dart';
import '../utils/app_color.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  ProductReviewController productReviewController =
      Get.find<ProductReviewController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productReviewController.getReviewList(widget.productId);
    });
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
        title: const Text('Reviews'),
      ),
      body: GetBuilder<ProductReviewController>(builder: (reviewController) {
        if (reviewController.inProgress) {
          return const LoadingIndicator();
        } else if (reviewController.reviewList == null ||
            reviewController.reviewList!.isEmpty) {
          return const Center(
            child: Text(
              'No reviews available.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: reviewController.reviewList!.length,
                    itemBuilder: (context, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 1,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width - 32,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      radius: 12.0,
                                      child: Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.black54,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      reviewController
                                          .reviewList![index].profile!.cusName!,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    reviewController
                                        .reviewList![index].description!,
                                    style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ),
            bottomBar(reviewController.reviewList!.length)
          ],
        );
      }),
    );
  }

  Widget bottomBar(int totalReviews) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$totalReviews Reviews",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54)),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.themeColor,
              ),
              child: IconButton(
                  onPressed: () {
                    addReview(widget.productId);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  )),
            )
          ],
        ),
      ),
    );
  }

  void addReview(int productId) async {
    final isLoggedIn = await Get.find<AuthController>().isLoggedInUser();

    if (!isLoggedIn) {
      showUnauthorizedDialog();
      return;
    } else {
      // Navigate to the CreateReviewScreen
      Get.to(() => CreateReviewScreen(
            productId: productId,
          ));
      return;
    }
  }

  void showUnauthorizedDialog() {
    Get.defaultDialog(
      title: 'Unauthorized Access',
      middleText:
          'You are not authorized to access this feature. Please login to continue.',
      textConfirm: 'Login',
      buttonColor: AppColors.themeColor,
      textCancel: 'Cancel',
      onConfirm: () {
        Get.back(); // Dismiss the dialog
        Get.to(() =>
            const EmailVerificationScreen()); // Navigate to the login page
      },
      onCancel: () {
        Get.back(); // Dismiss the dialog
      },
    );
  }
}
