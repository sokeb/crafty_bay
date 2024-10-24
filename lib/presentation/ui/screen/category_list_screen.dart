import 'package:crafty_bay_app/presentation/state_holder/bottom_navbar_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/categories_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/categories_card.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:crafty_bay_app/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, __) {
        Get.find<BottomNavbarController>().selectHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.find<BottomNavbarController>().selectHome();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(AppString.categories),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoriesListController>().getCategoriesList();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<CategoriesListController>(
                builder: (categoriesListController) {
              if (categoriesListController.inProgress) {
                return const LoadingIndicator();
              } else if (categoriesListController.errorMessage != null) {
                return Center(
                  child: Text(categoriesListController.errorMessage ?? ''),
                );
              }
              return GridView.builder(
                  itemCount: categoriesListController.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 0.7),
                  itemBuilder: (context, index) {
                    return CategoriesCard(
                      categories: categoriesListController.categories[index],
                    );
                  });
            }),
          ),
        ),
      ),
    );
  }
}
