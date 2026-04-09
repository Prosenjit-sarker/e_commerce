class ProductDetailsModel {
  final String id;
  final String title;
  final num currentPrice;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final List<String> tags;
  final int quantity;
  final String description;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.currentPrice,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.tags,
    required this.quantity,
    required this.description,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      currentPrice: json['current_price'] ?? 0,
      photos: List<String>.from(json['photos'] ?? const []),
      colors: List<String>.from(json['colors'] ?? const []),
      sizes: List<String>.from(json['sizes'] ?? const []),
      tags: List<String>.from(json['tags'] ?? const []),
      quantity: json['quantity'] ?? 0,
      description: json['description']?.toString() ?? '',
    );
  }
}
