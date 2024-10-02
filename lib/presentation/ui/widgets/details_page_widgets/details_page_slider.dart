import 'package:flutter/material.dart';

import '../../utils/assets_path.dart';

class DetailsPageSlider extends StatefulWidget {
  const DetailsPageSlider({super.key});

  @override
  State<DetailsPageSlider> createState() => _DetailsPageSliderState();
}

class _DetailsPageSliderState extends State<DetailsPageSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> imgList = [
    'https://via.placeholder.com/600x400.png?text=Slide+1',
    'https://via.placeholder.com/600x400.png?text=Slide+2',
    'https://via.placeholder.com/600x400.png?text=Slide+3',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage(AssetsPath.shoe1),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imgList.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentIndex == index ? 12.0 : 8.0,
                    height: _currentIndex == index ? 12.0 : 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}