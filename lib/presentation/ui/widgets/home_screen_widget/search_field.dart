import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../state_holder/search_controller.dart';
import 'custom_search_widget.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.find<SearchProductController>().getAllProductData();
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          );
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey.shade700,
                ),
                Text(
                  "Search",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
        ));
  }
}
