import 'package:crafty_bay/features/product/data/models/product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel productModel;
  int quantity;
  final String? size;
  final String? color;

  CartItemModel({
    required this.id,
    required this.productModel,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> productJson = (json['product'] ??
        json['productId'] ??
        const {}) as Map<String, dynamic>;

    return CartItemModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      productModel: ProductModel.fromJson(productJson),
      quantity: json['quantity'] ?? 1,
      color: json['color']?.toString(),
      size: json['size']?.toString(),
    );
  }
}
