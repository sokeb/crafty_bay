import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holder/bottom_navbar_controller.dart';
import '../utils/assets_path.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          title: const Text('Cart'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 1,
                        child: SizedBox(
                          height: 100,
                          //width: MediaQuery.sizeOf(context).width - 32,
                          width: 32,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(AssetsPath.shoe1),
                                            fit: BoxFit.scaleDown,
                                          )))),
                              const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Wrap(
                                          children: [
                                            Text('New Year Special Shoe',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.black54)),
                                          ],
                                        ),
                                        Text(
                                          'Color: Red, Size: X',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '\$100',
                                          style: TextStyle(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.delete_outline)),
                                        ItemCount(
                                          color: AppColors.themeColor,
                                          initialValue: 1,
                                          minValue: 1,
                                          maxValue: 5,
                                          decimalPlaces: 0,
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            buildTotalPriceAndCheckoutSection()
          ],
        ),
      ),
    );
  }

  Widget buildTotalPriceAndCheckoutSection() {
    return Container(
            decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Price',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54)),
                      SizedBox(
                        height: 2,
                      ),
                      Text('\$1000000.00',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.themeColor)),
                    ],
                  ),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Checkout')),
                  )
                ],
              ),
            ),
          );
  }
}
