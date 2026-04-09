import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/Presentation/widgets/center_circular_progress.dart';
import '../../../shared/Presentation/widgets/product_card.dart';
import '../providers/product_search_provider.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key, required this.query});

  static const String name = '/product-search';
  final String query;

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final ProductSearchProvider _searchProvider = ProductSearchProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchProvider.searchProducts(widget.query);
    });
  }

  @override
  void dispose() {
    _searchProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _searchProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${context.l10n.search}: ${widget.query}'),
        ),
        body: Consumer<ProductSearchProvider>(
          builder: (context, provider, child) {
            if (provider.searchInProgress) {
              return const CenterCircularProgress();
            }
            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }
            if (provider.products.isEmpty) {
              return Center(child: Text(context.l10n.noProductFound));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: provider.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: ProductCard(productModel: provider.products[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
