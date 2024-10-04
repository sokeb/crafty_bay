import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class BuiltColorSelectSection extends StatefulWidget {
  const BuiltColorSelectSection(
      {super.key, required this.onSelectedColor, required this.color});

  //final List<Color> colors;
  final Function(Color) onSelectedColor;
  final List<String> color;

  @override
  State<BuiltColorSelectSection> createState() =>
      _BuiltColorSelectSectionState();
}

class _BuiltColorSelectSectionState extends State<BuiltColorSelectSection> {
  //late Color _selectedColor = widget.colors.first;
  late String _selectedColor = widget.color.first;

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
              children: widget.color.map((item) {
                return GestureDetector(
                  onTap: () {
                    _selectedColor = item;
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _selectedColor == item
                              ? AppColors.themeColor
                              : Colors.black54),
                      color: _selectedColor == item
                          ? AppColors.themeColor
                          : Colors.white, // Border color
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                          color: _selectedColor == item
                              ? Colors.white
                              : Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );

    // return  SizedBox(
    //   height: 70,
    //   child: Scaffold(
    //     body: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start ,
    //       children: [
    //         const Text('color',
    //             style: TextStyle(
    //                 color: Colors.black54,
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w500)),
    //         Wrap(
    //           spacing: 8,
    //           children:
    //             widget.colors.map((item){
    //               return  GestureDetector(
    //                 onTap: (){ _selectedColor = item;
    //                   setState(() {});},
    //                 child: CircleAvatar(
    //                   backgroundColor: item,
    //                   radius: 16,
    //                   child: _selectedColor == item ? const Icon(Icons.check, color: Colors.white,): null,
    //                 ),
    //               );
    //             }).toList(),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
