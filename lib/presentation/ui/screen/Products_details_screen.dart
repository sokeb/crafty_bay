import 'package:crafty_bay_app/presentation/ui/screen/reviews_screen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/details_page_widgets/details_page_slider.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/details_page_widgets/built_size_select_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import '../utils/app_color.dart';
import '../widgets/details_page_widgets/built_color_select_section.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const DetailsPageSlider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BuiltNameQuantityReviewSection(),
                        BuiltColorSelectSection(
                          colors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.cyan,
                            Colors.brown,
                            Colors.blueAccent
                          ],
                          onSelectedColor: (color) {},
                        ),
                        const SizedBox(height: 8),
                        BuiltSizeSelectSection(
                          sizes: const ['S', 'M', 'L', 'XL'],
                          onSelectedSize: (color) {},
                        ),
                        const SizedBox(height: 16),
                        const Text('Description',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const Text(
                            '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book''',
                            style: TextStyle(
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
          buildTotalPriceAndAddToCartSection()
        ],
      ),
    );
  }

  Widget buildTotalPriceAndAddToCartSection() {
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54)),
                SizedBox(
                  height: 2,
                ),
                Text('\$1000',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.themeColor)),
              ],
            ),
            SizedBox(
              width: 130,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Add To Cart')),
            )
          ],
        ),
      ),
    );
  }
}

class BuiltNameQuantityReviewSection extends StatelessWidget {
  const BuiltNameQuantityReviewSection({
    super.key,
  });

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
              const Expanded(
                  child: Wrap(
                children: [
                  Text('Happy New Year Special Deal Save 30%',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ],
              )),
              ItemCount(
                color: AppColors.themeColor,
                initialValue: 1,
                minValue: 1,
                maxValue: 5,
                decimalPlaces: 0,
                onChanged: (value) {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  Text('4.8',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                          fontSize: 12))
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(()=> const ReviewsScreen());
                  },
                  child: const Text('Reviews',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                          fontSize: 12))),
              const SizedBox(
                width: 16,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.themeColor,
                    size: 16,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
