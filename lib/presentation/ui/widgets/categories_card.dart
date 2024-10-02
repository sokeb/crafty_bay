import 'package:crafty_bay_app/data/models/categories_model.dart';
import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:crafty_bay_app/presentation/ui/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    super.key,
    required this.categories,
  });

  final CategoriesModel categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => ProductListScreen(
                  title: categories.categoryName ?? '',
                  productList: [],
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.themeColor.withOpacity(0.1)),
            child: const Icon(
              Icons.computer,
              size: 55,
              color: AppColors.themeColor,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          categories.categoryName ?? '',
          style: const TextStyle(color: AppColors.themeColor),
        )
      ],
    );
  }
}
