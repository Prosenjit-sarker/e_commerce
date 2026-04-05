import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../category/presentation/providers/category_list_provider.dart';
import '../../../shared/Presentation/widgets/categori_card.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
          if (categoryListProvider.getInitialCategoryListInProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: getCategoryListLength(
              categoryListProvider.categories.length,
            ),
            itemBuilder: (context, index) => CategoryCard(
              categoryModel: categoryListProvider.categories[index],
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
          );
        },
      ),
    );
  }

  int getCategoryListLength(int length) {
    return length > 10 ? 10 : length;
  }
}
