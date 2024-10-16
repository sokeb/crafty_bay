import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/create_product_review_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_review_controller.dart';
import 'package:crafty_bay_app/utils/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ratingTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Create Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                validator: (rating) {
                  if (rating == null || rating.isEmpty) {
                    return 'This flied is require';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                controller: _ratingTEController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Product rating out of 5'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (review) {
                  if (review == null || review.isEmpty) {
                    return 'This flied is require';
                  }
                  return null;
                },
                maxLines: 6,
                keyboardType: TextInputType.text,
                controller: _reviewTEController,
                decoration: const InputDecoration(hintText: 'Write Review'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitReview(widget.productId);
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitReview(int productId) async {
    CreateProductReviewController reviewController =
        Get.find<CreateProductReviewController>();

    final bool isReviewCreated = await reviewController.createReview(
        productId: productId,
        rating: int.parse(_ratingTEController.text),
        review: _reviewTEController.text,
        token: Get.find<AuthController>().token);
    if (mounted && isReviewCreated) {
      showSnackBar(context, 'Successfully added your review', true);
      Get.back();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.find<ProductReviewController>().getReviewList(productId);
      });
      return;
    } else {
      if (mounted) {
        showSnackBar(context, reviewController.errorMessage!);
        return;
      }
    }
  }
}
