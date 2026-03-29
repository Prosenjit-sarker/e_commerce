import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/product/presentation/widgets/product_image_carousel.dart';
import 'package:crafty_bay/features/shared/Presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/Presentation/widgets/product_favorite_button.dart';
import '../../../shared/Presentation/widgets/product_rating.dart';
import '../widgets/price_and_add_to_cart_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product details')),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ProductImageCarousel(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        spacing: 8,
                        crossAxisAlignment: .start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nike 2026 - New Year Special Edition five star',
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(color: Colors.black87),
                                ),
                                Row(
                                  children: [
                                    ProductRating(rating: '4.6'),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text('Reviews',style: TextStyle(
                                        color: AppColors.themeColor,
                                      ),),
                                    ),
                                    ProductFavoriteButton(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IncDecButton(onChange: (int count) {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PriceAndAddToCartSection(price: 120.34, onTapAddToCart: () {}),
        ],
      ),
    );
  }
}
