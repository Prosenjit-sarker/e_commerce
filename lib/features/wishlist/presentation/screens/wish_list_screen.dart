import 'package:crafty_bay/features/shared/Presentation/widgets/center_circular_progress.dart';
import 'package:crafty_bay/features/wishlist/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/Presentation/widgets/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  static const name = '/wish-list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishListProvider _wishListProvider = WishListProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _wishListProvider.getWishList();
    });
  }

  @override
  void dispose() {
    _wishListProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _wishListProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.wishlist)),
        body: Consumer<WishListProvider>(
          builder: (context, provider, child) {
            if (provider.getWishListInProgress) {
              return const CenterCircularProgress();
            }

            if (provider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(provider.errorMessage!),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: provider.getWishList,
                      child: Text(context.l10n.retry),
                    ),
                  ],
                ),
              );
            }

            if (provider.wishListProducts.isEmpty) {
              return Center(
                child: Text(context.l10n.yourWishlistIsEmpty),
              );
            }

            return RefreshIndicator(
              onRefresh: provider.getWishList,
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: provider.wishListProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(
                    child: ProductCard(
                      productModel: provider.wishListProducts[index],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
