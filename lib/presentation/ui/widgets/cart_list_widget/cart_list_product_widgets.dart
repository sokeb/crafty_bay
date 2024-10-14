import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import '../../../../data/models/cart_list_model.dart';
import '../../utils/app_color.dart';

class CartListProductCard extends StatefulWidget {
  const CartListProductCard({
    super.key,
    required this.cartProduct,
  });

  final CartDataModel cartProduct;

  @override
  State<CartListProductCard> createState() => _CartListProductCardState();
}

class _CartListProductCardState extends State<CartListProductCard> {
  @override
  Widget build(BuildContext context) {
    int productQuantity = int.parse(widget.cartProduct.qty!);
    return Card(
      color: Colors.white,
      elevation: 1,
      child: SizedBox(
        height: 120,
        width: MediaQuery.sizeOf(context).width - 32,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(widget.cartProduct.productData!.image!),
                          fit: BoxFit.cover,
                        )))),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          Text(widget.cartProduct.productData!.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black54)),
                        ],
                      ),
                      Text(
                        'Color: ${widget.cartProduct.color}, '
                        'Size: ${widget.cartProduct.size}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${widget.cartProduct.price}',
                        style: const TextStyle(
                            color: AppColors.themeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline)),
                      FittedBox(
                        child: ItemCount(
                          color: AppColors.themeColor,
                          initialValue: productQuantity,
                          minValue: 1,
                          maxValue: 5,
                          decimalPlaces: 0,
                          onChanged: (value) {
                            productQuantity = value.toInt();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}


