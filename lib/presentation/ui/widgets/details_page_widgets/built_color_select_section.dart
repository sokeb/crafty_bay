import 'package:flutter/material.dart';

class BuiltColorSelectSection extends StatefulWidget {
  const BuiltColorSelectSection(
      {super.key, required this.colors, required this.onSelectedColor});

  final List<Color> colors;
  final Function(Color) onSelectedColor;

  @override
  State<BuiltColorSelectSection> createState() =>
      _BuiltColorSelectSectionState();
}

class _BuiltColorSelectSectionState extends State<BuiltColorSelectSection> {
  late Color _selectedColor = widget.colors.first;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 70,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            const Text('color',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            Wrap(
              spacing: 8,
              children:
                widget.colors.map((item){
                  return  GestureDetector(
                    onTap: (){ _selectedColor = item;
                      setState(() {});},
                    child: CircleAvatar(
                      backgroundColor: item,
                      radius: 16,
                      child: _selectedColor == item ? const Icon(Icons.check, color: Colors.white,): null,
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
