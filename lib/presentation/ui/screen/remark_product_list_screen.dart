import 'package:crafty_bay_app/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class ProductListByRemarkScreen extends StatefulWidget {
  const ProductListByRemarkScreen(
      {super.key, required this.productList, required this.name});

  final List<ProductModel> productList;
  final String name;

  @override
  State<ProductListByRemarkScreen> createState() =>
      _ProductListByRemarkScreenState();
}

class _ProductListByRemarkScreenState extends State<ProductListByRemarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(widget.name),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: widget.productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 0.1),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: ProductCard(
                    products: widget.productList[index],
                  ),
                );
              })),
    );
  }
}
