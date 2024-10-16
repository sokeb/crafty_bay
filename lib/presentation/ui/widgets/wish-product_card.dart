import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/assets_path.dart';

class WishProductCard extends StatelessWidget {
  const WishProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              // onTap: () {
              //   Get.to(() => const ProductsDetailsScreen( ));
              // },
              child: Container(
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: AppColors.themeColor.withOpacity(0.1),
                    image: const DecorationImage(
                      image: AssetImage(AssetsPath.shoe1),
                      fit: BoxFit.scaleDown,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Special Shoe',
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black45),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('\$120',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.themeColor,
                              fontSize: 12)),
                      const Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          Text('4',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45,
                                  fontSize: 12))
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Card(
                          color: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
