import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';

class TotalPriceAndCheckoutSection extends StatelessWidget {
  const TotalPriceAndCheckoutSection({
    super.key, required this.totalPrice, required this.onTapCheckout,
  });

  final double totalPrice;
  final VoidCallback onTapCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: AppColors.themeColor.withAlpha(30)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.totalPrice,style: context.textTheme.bodyLarge,),
              Text('${Constants.takaSign}$totalPrice',style: context.textTheme.titleLarge?.copyWith(
                color: AppColors.themeColor,
              ),)
            ],

          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              fixedSize: const Size.fromWidth(120),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onTapCheckout,
            child: Text(context.l10n.checkout,style: const TextStyle(
              color: Colors.white
            ),),
          ),

        ],
      ),
    );
  }
}
