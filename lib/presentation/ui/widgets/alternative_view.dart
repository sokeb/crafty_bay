import 'package:flutter/cupertino.dart';
class AlternativeView extends StatelessWidget {
  const AlternativeView(
      {super.key, required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          Center(child: Text(title)),
          content,
        ],
      ),
    );
  }
}
