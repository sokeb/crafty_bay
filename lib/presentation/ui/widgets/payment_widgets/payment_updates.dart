import 'package:flutter/material.dart';

class PaymentStatus extends StatelessWidget {
  final bool isSuccess;
  final String headerText, subtitleText;

  const PaymentStatus(
      {super.key,
      required this.headerText,
      required this.subtitleText,
      required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Icon(isSuccess ? Icons.done : Icons.sms_failed),
                ),
                Positioned(
                  top: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        headerText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          subtitleText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
