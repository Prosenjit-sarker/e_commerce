import 'package:flutter/material.dart';
import '../../../../app/extensions/utils_extension.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: context.l10n.search,
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Icon(Icons.search),
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
