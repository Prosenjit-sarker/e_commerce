class WishListModel {
  final String id;
  final int quantity;
  final String? size;
  final String? color;

  WishListModel({
    required this.id,
    required this.quantity,
    this.size,
    this.color,
  });

  Map<String,dynamic> toJson() {
    Map<String,dynamic> data = {
      'product':id,
      'quantity':quantity,
    };
    if(size != null){
      data['size'] = size;
    }
    if(color != null) {
      data['color'] = color;
    }
    return data;
  }

}
