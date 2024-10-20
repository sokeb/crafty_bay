import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Center(
            child: SizedBox(
                height: 150,
                child: Lottie.asset(
                  isSuccess
                      ? "assets/lottie's/done.json"
                      : "assets/lottie's/lottie4.json",
                  repeat: false,
                )),
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          headerText,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            subtitleText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
