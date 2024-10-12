import 'dart:async';
import 'package:flutter/material.dart';

class DetailsPageSlider extends StatefulWidget {
  const DetailsPageSlider({super.key, required this.sliderImgUrls});

  final List<String> sliderImgUrls;

  @override
  State<DetailsPageSlider> createState() => _DetailsPageSliderState();
}

class _DetailsPageSliderState extends State<DetailsPageSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide(widget.sliderImgUrls.length);
  }

  void _startAutoSlide(int listLength) {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < listLength - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
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
              itemCount: widget.sliderImgUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.sliderImgUrls[index]),
                      fit: BoxFit.fill,
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
                children: List.generate(widget.sliderImgUrls.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentIndex == index ? 12.0 : 8.0,
                    height: _currentIndex == index ? 12.0 : 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.blueAccent
                          : Colors.grey,
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

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _pageController.dispose();
  }
}
