import 'package:crafty_bay_app/data/models/categories_model.dart';
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
                  category: categories,
                ));
          },
          child: Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(
                    categories.categoryImg ?? '',
                  ),
                  fit: BoxFit.scaleDown,
                )),
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
