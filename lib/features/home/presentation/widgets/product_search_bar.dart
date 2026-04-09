import 'package:flutter/material.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../screens/product_search_screen.dart';

class ProductSearchBar extends StatefulWidget {
  const ProductSearchBar({
    super.key,
  });

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  void _onTapSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      return;
    }
    Navigator.pushNamed(context, ProductSearchScreen.name, arguments: query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => _onTapSearch(),
      decoration: InputDecoration(
        hintText: context.l10n.search,
        contentPadding: EdgeInsets.zero,
        prefixIcon: IconButton(
          onPressed: _onTapSearch,
          icon: const Icon(Icons.search),
        ),
        filled: true,
        fillColor: Colors.grey.withAlpha(50),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),

        ),

      ),
    );
  }
}
