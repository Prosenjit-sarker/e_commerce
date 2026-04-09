import 'package:crafty_bay/features/product/data/models/add_to_cart_model.dart';
import 'package:crafty_bay/features/product/presentation/providers/add_to_cart_provider.dart';
import 'package:crafty_bay/features/shared/Presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../data/models/product_details_model.dart';
import '../../../reviews/presentations/screens/review_screen.dart';
import '../../../shared/Presentation/widgets/inc_dec_button.dart';
import '../../../shared/Presentation/widgets/product_favorite_button.dart';
import '../../../shared/Presentation/widgets/product_rating.dart';
import '../providers/product_details_provider.dart';
import '../widgets/color_picker.dart';
import '../widgets/price_and_add_to_cart_section.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  static const name = '/product-details';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider =
      ProductDetailsProvider();
  final AddToCartProvider _addToCartProvider = AddToCartProvider();

  int _quantity = 1;
  String? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsProvider.getProductDetails(widget.productId);
    });
  }

  @override
  void dispose() {
    _productDetailsProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _productDetailsProvider),
        ChangeNotifierProvider.value(value: _addToCartProvider),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Product details')),
        body: Consumer<ProductDetailsProvider>(
          builder: (context, provider, child) {
            if (_productDetailsProvider.getProductDataInProgress) {
              return const CenterCircularProgress();
            } else if (_productDetailsProvider.errorMessage != null) {
              return Center(child: Text(_productDetailsProvider.errorMessage!));
            }
            final productDetails = _productDetailsProvider.productDetailsModel;
            if (productDetails == null) {
              return const Center(child: Text('Product details not found'));
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(imageUrls: productDetails.photos),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTitleSection(productDetails),
                              if (_productDetailsProvider
                                  .productDetailsModel!
                                  .colors
                                  .isNotEmpty) ...[
                                ColorPicker(
                                  colors: _productDetailsProvider
                                      .productDetailsModel!
                                      .colors,
                                  onChange: (String color) {
                                    _selectedColor = color;
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                              if (_productDetailsProvider
                                  .productDetailsModel!
                                  .sizes
                                  .isNotEmpty) ...[
                                SizePicker(
                                  sizes: _productDetailsProvider
                                      .productDetailsModel!
                                      .sizes,
                                  onChange: (String size) {
                                    _selectedSize = size;
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                              Text(
                                'Description',
                                style: context.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _productDetailsProvider
                                    .productDetailsModel!
                                    .description,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PriceAndAddToCartSection(
                  price: _productDetailsProvider
                      .productDetailsModel!
                      .currentPrice
                      .toDouble(),
                  onTapAddToCart: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    AddToCartModel params = AddToCartModel(
                      id: _productDetailsProvider.productDetailsModel!.id,
                      quantity: _quantity,
                      color: _selectedColor,
                      size: _selectedSize,
                    );
                    final isSuccess = await _addToCartProvider.addToCart(params);
                    if (!mounted) {
                      return;
                    }
                    if (isSuccess) {
                      messenger.showSnackBar(
                        SnackBar(content: Text('Added to cart')),
                      );
                    } else {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(_addToCartProvider.errorMessage!),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitleSection(ProductDetailsModel productDetails) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productDetails.title,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  ProductRating(rating: '4.6'),
                  const SizedBox(width: 8),
                  Text(
                    '${Constants.takaSign}${productDetails.currentPrice}',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ReviewScreen.name);
                    },
                    child: Text(
                      'Reviews',
                      style: TextStyle(color: AppColors.themeColor),
                    ),
                  ),
                  ProductFavoriteButton(productId: productDetails.id),
                ],
              ),
            ],
          ),
        ),
        IncDecButton(
          maxCount: _productDetailsProvider.productDetailsModel!.quantity,
          onChange: (int count) {
            _quantity = count;
          },
        ),
      ],
    );
  }
}
