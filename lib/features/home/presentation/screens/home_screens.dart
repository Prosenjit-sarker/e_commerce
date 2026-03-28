import 'package:crafty_bay/features/home/presentation/widgets/home_slider.dart';
import 'package:crafty_bay/features/home/presentation/widgets/product_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              SectionHeader(name: 'Categories', onTapSeeAll: () {}),
              HomeCategoryList(),
              SectionHeader(name: 'Popular', onTapSeeAll: () {}),
              HorizontalProductListView(),
              SectionHeader(name: 'Special', onTapSeeAll: () {}),
              HorizontalProductListView(),
              SectionHeader(name: 'New', onTapSeeAll: () {}),
              HorizontalProductListView(),
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
