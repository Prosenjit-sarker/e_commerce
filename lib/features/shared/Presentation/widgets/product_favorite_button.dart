import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../wishlist/presentation/providers/wish_list_provider.dart';
import 'snack_bar_message.dart';

class ProductFavoriteButton extends StatefulWidget {
  const ProductFavoriteButton({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductFavoriteButton> createState() => _ProductFavoriteButtonState();
}

class _ProductFavoriteButtonState extends State<ProductFavoriteButton> {
  final WishListProvider _wishListProvider = WishListProvider();
  bool _isAdding = false;

  @override
  void dispose() {
    _wishListProvider.dispose();
    super.dispose();
  }

  Future<void> _onTapFavorite() async {
    if (_isAdding) {
      return;
    }

    setState(() {
      _isAdding = true;
    });

    final bool isSuccess = await _wishListProvider.addWishList(widget.productId);
    if (!mounted) {
      return;
    }

    setState(() {
      _isAdding = false;
    });

    if (isSuccess) {
      showSnackBarMessage(context, 'Added to wishlist');
    } else {
      showSnackBarMessage(
        context,
        _wishListProvider.errorMessage ?? 'Failed to add wishlist',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: _onTapFavorite,
      child: Container(
        width: 20,
        height: 20,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: _isAdding
            ? const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(
                Icons.favorite_outline,
                color: Colors.white,
                size: 16,
              ),
      ),
    );
  }
}
