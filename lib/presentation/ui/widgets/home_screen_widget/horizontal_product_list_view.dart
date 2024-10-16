import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../product_card.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
    required this.productList,
  });

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCard(
            products: productList[index],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 5),
        itemCount: productList.length,
      ),
    );
  }
}
