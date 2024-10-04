import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';

class BuiltSizeSelectSection extends StatefulWidget {
  const BuiltSizeSelectSection({
    super.key,
    required this.sizes,
    required this.onSelectedSize,
  });

  final List<String> sizes;
  final Function(Color) onSelectedSize;

  @override
  State<BuiltSizeSelectSection> createState() => _BuiltSizeSelectSectionState();
}

class _BuiltSizeSelectSectionState extends State<BuiltSizeSelectSection> {
  late String _selectedSize = widget.sizes.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Size',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            Wrap(
              spacing: 8,
              children: widget.sizes.map((item) {
                return GestureDetector(
                  onTap: () {
                    _selectedSize = item;
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: _selectedSize == item
                          ? AppColors.themeColor
                          : Colors.black54, // Border color
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: _selectedSize == item
                          ? AppColors.themeColor
                          : Colors.white,
                      radius: 16.0,
                      child: Text(
                        item,
                        style: TextStyle(
                            color: _selectedSize == item
                                ? Colors.white
                                : Colors.black54),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
