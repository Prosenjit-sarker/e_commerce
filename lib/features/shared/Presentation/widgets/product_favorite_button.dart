import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class ProductFavoriteButton extends StatelessWidget {
  const ProductFavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(2),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.favorite_outline,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}