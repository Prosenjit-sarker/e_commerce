import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/Presentation/widgets/center_circular_progress.dart';
import '../providers/add_to_cart_provider.dart';

class PriceAndAddToCartSection extends StatelessWidget {
  const PriceAndAddToCartSection({
    super.key, required this.price, required this.onTapAddToCart,
  });

  final double price;
  final VoidCallback onTapAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: .only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: AppColors.themeColor.withAlpha(30)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Price',style: context.textTheme.bodyLarge,),
              Text('${Constants.takaSign}$price',style: context.textTheme.titleLarge?.copyWith(
                color: AppColors.themeColor,
              ),)
            ],

          ),
          Consumer<AddToCartProvider>(
            builder: (context, cartProvider, child) {
              if(cartProvider.addToCartInProgress){
                return  CenterCircularProgress();
              }
              return TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  fixedSize: const Size.fromWidth(120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onTapAddToCart,
                child: const Text('Add to Cart',style: TextStyle(
                  color: Colors.white
                ),),
              );
            }
          ),

        ],
      ),
    );
  }
}
