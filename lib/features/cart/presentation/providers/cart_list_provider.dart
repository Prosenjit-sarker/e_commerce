import 'package:crafty_bay/features/cart/presentation/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class CartListProvider extends ChangeNotifier {
  List<CartItemModel> _cartItems = [];

  bool _getCartListInProgress = true;

  bool get getCartListInProgress => _getCartListInProgress;

  List<CartItemModel> get cartItems => _cartItems;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _getCartListInProgress = true;
    _errorMessage = null;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getCartListUrl,
    );
    if (response.isSuccess) {
      List<CartItemModel> cartList = [];
      final dynamic data = response.body['data'];
      final List<dynamic> results;
      if (data is Map<String, dynamic> && data['results'] is List) {
        results = data['results'] as List<dynamic>;
      } else if (data is List) {
        results = data;
      } else {
        results = const [];
      }

      for (final dynamic product in results) {
        if (product is Map<String, dynamic>) {
          cartList.add(CartItemModel.fromJson(product));
        }
      }
      _cartItems = cartList;

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
      _cartItems = [];
    }
    _getCartListInProgress = false;
    notifyListeners();

    return isSuccess;
  }

  int get totalCartItems => _cartItems.length;

  double get totalPrice {
    double totalPrice = 0;
    for (CartItemModel cartItem in _cartItems) {
      totalPrice += (cartItem.productModel.currentPrice * cartItem.quantity);
    }
    return totalPrice;
  }

  void addQuantity(String cartItemId, int quantity) {
    for (CartItemModel cartItem in _cartItems) {
      if (cartItem.id == cartItemId) {
        cartItem.quantity = quantity;
        notifyListeners();
        break;
      }
    }
  }
}
