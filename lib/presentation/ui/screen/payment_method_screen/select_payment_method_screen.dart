import 'package:crafty_bay_app/presentation/state_holder/auth_controller/auth_controller.dart';
import 'package:crafty_bay_app/presentation/state_holder/payment_method_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_color.dart';
import 'card_banking.dart';
import 'internet_banking.dart';
import 'mobile_banking.dart';

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
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text('Payment Methods'),
          ),
          body:
              GetBuilder<PaymentMethodController>(builder: (methodController) {
            if (methodController.inProgress) {
              return const LoadingIndicator();
            }

            if (methodController.paymentMethodData == null ||
                methodController.paymentMethodData!.paymentMethod == null) {
              return const Center(child: Text('No payment methods available'));
            }

            return Column(
              children: [
                Expanded(
                  flex: 8,
                  child: TabBarView(
                    children: [
                      Banking(data: methodController.mobileBankingData),
                      InternetBanking(
                          data: methodController.internetBankingData),
                      CartBanking(data: methodController.cardData),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 0.7,
                  dividerColor: Colors.white,
                  automaticIndicatorColorAdjustment: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.themeColor,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(fontSize: 14),
                  overlayColor: WidgetStateProperty.resolveWith<Color>((state) {
                    return AppColors.themeColor;
                  }),
                  labelPadding: const EdgeInsets.all(2),
                  splashBorderRadius: BorderRadius.circular(5),
                  tabs: const [
                    Tab(
                      text: "Mobile Banking",
                    ),
                    Tab(
                      text: 'Internet Banking',
                    ),
                    Tab(
                      text: "Card",
                    )
                  ],
                )),
                buildTotalPriceAndCheckoutSection(methodController)
              ],
            );
          }),
        ),
      ),
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
                Text('\$${methodController.paymentMethodData!.total}',
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
                Text('\$${methodController.paymentMethodData!.vat}',
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
                Text('\$${methodController.paymentMethodData!.payable}',
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
