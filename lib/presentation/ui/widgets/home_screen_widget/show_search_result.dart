import 'package:crafty_bay_app/presentation/ui/screen/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../../../../utils/app_string.dart';
import '../../utils/app_color.dart';

class SearchResult extends StatelessWidget {
  final List<ProductModel> matchedQuery;

  const SearchResult({super.key, required this.matchedQuery});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 10,
            top: 5,
          ),
          child: Text(
            AppString.matchedProduct,
            style: TextStyle(
                color: AppColors.themeColor, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: matchedQuery.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Get.off(() => ProductsDetailsScreen(
                      productId: matchedQuery[index].id!));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.grey.shade100,
                title: Text(
                  matchedQuery[index].title!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$${matchedQuery[index].price!}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
                leading: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    matchedQuery[index].image!,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          ),
        ),
      ],
    );
  }
}
