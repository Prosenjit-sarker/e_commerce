import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 180,
              viewportFraction: 1,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 1),
            onPageChanged: (index, reason){
              _currentIndex.value = index;

            }
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: .center,
                  child: Text('text $i', style: TextStyle(fontSize: 16.0)),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8,),
        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               for(int i = 0; i<=5; i++)
                 Container(
                   width: 10,
                   height: 10,
                   margin: EdgeInsets.only(right: 4),
                   decoration: BoxDecoration(
                     color:value == i ? AppColors.themeColor : Colors.white,
                    border: Border.all(color:AppColors.themeColor),

                     shape: BoxShape.circle,
                   ),
                 )
              ],
            );
          }
        )
      ],
    );
  }
}
