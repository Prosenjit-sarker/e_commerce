import 'package:crafty_bay/features/product/presentation/providers/product_list_provider.dart';
import 'package:crafty_bay/features/shared/Presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/extensions/utils_extension.dart';

import '../../../shared/Presentation/widgets/product_card.dart';

class HorizontalProductListView extends StatefulWidget {
  const HorizontalProductListView({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  State<HorizontalProductListView> createState() =>
      _HorizontalProductListViewState();
}

class _HorizontalProductListViewState extends State<HorizontalProductListView> {
  final ProductListProvider _productListProvider = ProductListProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListProvider.getProducts(widget.categoryId);
    });
  }

  @override
  void dispose() {
    _productListProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productListProvider,
      child: Consumer<ProductListProvider>(
        builder: (context, provider, child) {
          if (provider.getInitialProductListInProgress) {
            return const SizedBox(
              height: 215,
              child: CenterCircularProgress(),
            );
          }
          if (provider.errorMessage != null) {
            return SizedBox(
              height: 215,
              child: Center(child: Text(provider.errorMessage!)),
            );
          }
          if (provider.products.isEmpty) {
            return SizedBox(
              height: 215,
              child: Center(child: Text(context.l10n.noProductFound)),
            );
          }

          return SizedBox(
            height: 215,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: provider.products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ProductCard(productModel: provider.products[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
