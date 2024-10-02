import 'package:crafty_bay_app/data/models/categories_model.dart';
import 'package:crafty_bay_app/presentation/state_holder/product_list_by_category_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen(
      {super.key, required this.category});

  final CategoriesModel category;


  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>()
        .getProductByCategoryList(widget.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.categoryName ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ProductListByCategoryController>(
            builder: (productListByCategoryController) {
          if (productListByCategoryController.inProgress) {
            return const Center(
              child: LoadingIndicator(),
            );
          }
          if (productListByCategoryController.errorMessage != null) {
            return Center(
              child: Text(productListByCategoryController.errorMessage!),
            );
          }
          if(productListByCategoryController.productList.isEmpty){
            return const  Center(child: Text('No Product Available'),);
          }

          return GridView.builder(
              itemCount: productListByCategoryController.productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 0.1),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: ProductCard(
                    products: productListByCategoryController.productList[index],
                  ),
                );
              });
        }),
      ),
    );
  }
}
