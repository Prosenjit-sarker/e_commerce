import 'package:crafty_bay/features/category/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/home/presentation/widgets/home_slider.dart';
import 'package:crafty_bay/features/home/presentation/widgets/product_search_bar.dart';
import 'package:crafty_bay/features/shared/Presentation/providers/main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../app/asset_paths.dart';
import '../widgets/app_bar_icon_button.dart';
import '../widgets/home_category_list.dart';
import '../widgets/horizontal_product_list_view.dart';
import '../widgets/section_header.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  String? _findCategoryIdByKeywords(
    List<CategoryModel> categories,
    List<String> keywords, {
    List<String> excludeIds = const [],
  }) {
    for (final category in categories) {
      if (excludeIds.contains(category.id)) {
        continue;
      }
      final title = category.title.toLowerCase();
      if (keywords.any((keyword) => title.contains(keyword))) {
        return category.id;
      }
    }
    return null;
  }

  String _findFallbackCategoryId(
    List<CategoryModel> categories, {
    List<String> excludeIds = const [],
  }) {
    for (final category in categories) {
      if (!excludeIds.contains(category.id)) {
        return category.id;
      }
    }
    return categories.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearchBar(),
              const SizedBox(height: 16),
              HomeSlider(),
              const SizedBox(height: 16),
              SectionHeader(name: 'Categories',
                  onTapSeeAll: context.read<MainNavProvider>().moveToCategory,

                  ),
              HomeCategoryList(),
              Consumer<CategoryListProvider>(
                builder: (context, categoryProvider, child) {
                  if (categoryProvider.getInitialCategoryListInProgress) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (categoryProvider.categories.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('No categories found'),
                    );
                  }

                  final categories = categoryProvider.categories;

                  final String popularCategoryId =
                      _findCategoryIdByKeywords(categories, ['popular']) ??
                          _findFallbackCategoryId(categories);
                  final String specialCategoryId =
                      _findCategoryIdByKeywords(
                        categories,
                        ['special'],
                        excludeIds: [popularCategoryId],
                      ) ??
                      _findFallbackCategoryId(
                        categories,
                        excludeIds: [popularCategoryId],
                      );
                  final String newCategoryId =
                      _findCategoryIdByKeywords(
                        categories,
                        ['new'],
                        excludeIds: [popularCategoryId, specialCategoryId],
                      ) ??
                      _findFallbackCategoryId(
                        categories,
                        excludeIds: [popularCategoryId, specialCategoryId],
                      );

                  return Column(
                    children: [
                      SectionHeader(name: 'Popular', onTapSeeAll: () {}),
                      HorizontalProductListView(
                        key: ValueKey('popular-$popularCategoryId'),
                        categoryId: popularCategoryId,
                      ),
                      SectionHeader(name: 'Special', onTapSeeAll: () {}),
                      HorizontalProductListView(
                        key: ValueKey('special-$specialCategoryId'),
                        categoryId: specialCategoryId,
                      ),
                      SectionHeader(name: 'New', onTapSeeAll: () {}),
                      HorizontalProductListView(
                        key: ValueKey('new-$newCategoryId'),
                        categoryId: newCategoryId,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    title: SvgPicture.asset(AssetPaths.navLogoSvg),
    actions: [
      AppBarIconButton(onTap: () {}, icon: Icons.person),
      const SizedBox(width: 4),
      AppBarIconButton(onTap: () {}, icon: Icons.call),
      const SizedBox(width: 4),

      AppBarIconButton(onTap: () {}, icon: Icons.notifications_active_outlined),
    ],
  );
}
