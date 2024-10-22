import 'dart:async';
import 'package:crafty_bay_app/presentation/ui/screen/products_details_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../state_holder/slider_list_controller.dart';
import '../loading_widget.dart';

class HomeBannerSlider2 extends StatefulWidget {
  const HomeBannerSlider2({super.key});

  @override
  State<HomeBannerSlider2> createState() => _HomeBannerSlider2State();
}

class _HomeBannerSlider2State extends State<HomeBannerSlider2> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < Get.find<SliderListController>().sliders.length - 1) {
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
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SliderListController>(builder: (sliderListController) {
        return Visibility(
          visible: !sliderListController.inProgress,
          replacement: const LoadingIndicator(),
          child: Column(
            children: [
              buildSliderPage(sliderListController),
              const SizedBox(
                height: 6,
              ),
              buildSliderIndicator(sliderListController),
            ],
          ),
        );
      }),
    );
  }

  Widget buildSliderPage(SliderListController sliderListController) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: sliderListController.sliders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.themeColor,
                  image: DecorationImage(
                      image: NetworkImage(
                          sliderListController.sliders[index].image ?? ''),
                      fit: BoxFit.fill)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sliderListController.sliders[index].price ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.themeColor,
                          ),
                          onPressed: () {
                            Get.to(() => ProductsDetailsScreen(
                                productId: sliderListController
                                    .sliders[index].productId!));
                          },
                          child: const Text('Buy Now'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row buildSliderIndicator(SliderListController sliderListController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(sliderListController.sliders.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentIndex == index ? 12.0 : 8.0,
          height: _currentIndex == index ? 12.0 : 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? AppColors.themeColor : Colors.grey,
          ),
        );
      }),
    );
  }
}
