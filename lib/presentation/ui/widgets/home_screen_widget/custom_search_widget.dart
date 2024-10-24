import 'package:crafty_bay_app/presentation/state_holder/search_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/home_screen_widget/show_search_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/product_model.dart';
import '../../../../utils/app_string.dart';
import '../../utils/app_color.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<ProductModel> _allProducts =
      Get.find<SearchProductController>().allProducts;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = AppString.nullValue;
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: AppColors.themeColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 100,
              color: AppColors.themeColor,
            ),
            Text(AppString.searchWithName),
          ],
        ),
      );
    }
    List<ProductModel> matchQuery = [];
    for (ProductModel product in _allProducts) {
      if (product.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    if (matchQuery.isEmpty) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.search_off_outlined,
              size: 100,
              color: AppColors.themeColor,
            ),
          ),
          Text(AppString.noMatchFound),
        ],
      );
    }
    return SearchResult(matchedQuery: matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 100,
            color: AppColors.themeColor,
          ),
          Text(AppString.searchWithName),
        ],
      ),
    );
  }
}
