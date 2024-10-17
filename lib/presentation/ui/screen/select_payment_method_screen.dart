import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/payment_method_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Get.find<AuthController>();
      Get.find<PaymentMethodController>()
          .getPaymentMethodData(authController.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Payment Methods'),
      ),
      body: GetBuilder<PaymentMethodController>(builder: (methodController) {
        if (methodController.inProgress) {
          return const LoadingIndicator();
        }

        if (methodController.paymentMethodData.isEmpty ||
            methodController.paymentMethodData[0].paymentMethod == null) {
          return const Center(child: Text('No payment methods available'));
        }

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: methodController
                      .paymentMethodData[0].paymentMethod!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8.0, // Updated spacing for better layout
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ());
                      },
                      child: Card(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.themeColor.withOpacity(0.1),
                            image: DecorationImage(
                              image: NetworkImage(methodController
                                  .paymentMethodData[0]
                                  .paymentMethod![index]
                                  .logo!),
                              fit: BoxFit
                                  .scaleDown, // Updated fit for better scaling
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            buildTotalPriceAndCheckoutSection(methodController)
          ],
        );
      }),
    );
  }

  Widget buildTotalPriceAndCheckoutSection(
      PaymentMethodController methodController) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54)),
                const SizedBox(
                  height: 2,
                ),
                Text('\$${methodController.paymentMethodData[0].total}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.themeColor))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vat',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54)),
                const SizedBox(
                  height: 2,
                ),
                Text('\$${methodController.paymentMethodData[0].vat}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.themeColor))
              ],
            ),
            const SizedBox(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payable',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54)),
                const SizedBox(
                  height: 2,
                ),
                Text('\$${methodController.paymentMethodData[0].payable}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.themeColor))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
