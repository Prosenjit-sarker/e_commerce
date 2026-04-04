import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/Presentation/widgets/center_circular_progress.dart';
import '../providers/home_slider_provider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSliderProvider>(
      builder: (context, homeSliderProvider, _) {
        if (homeSliderProvider.getHomeSlidersInProgress) {
          return const SizedBox(height: 180, child: CenterCircularProgress());
        }

        if (homeSliderProvider.homeSliders.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: 1,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 1),
                onPageChanged: (index, reason) {
                  _currentIndex.value = index;
                },
              ),
              items: homeSliderProvider.homeSliders.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            slider.photoUrl,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            height: double.maxFinite,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const CenterCircularProgress();
                            },
                            errorBuilder: (context, child, loadingProgress) {
                              return Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.broken_image_outlined,
                                  size: 36,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (
                      int i = 0;
                      i < homeSliderProvider.homeSliders.length;
                      i++
                    )
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: value == i
                              ? AppColors.themeColor
                              : Colors.white,
                          border: Border.all(color: AppColors.themeColor),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }
}
