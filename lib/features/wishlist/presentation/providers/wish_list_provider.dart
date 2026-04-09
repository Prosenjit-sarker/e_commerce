import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';
import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class WishListProvider extends ChangeNotifier {
  List<ProductModel> _wishListProducts = [];
  bool _getWishListInProgress = true;
  bool _wishListInProgress = false;

  List<ProductModel> get wishListProducts => _wishListProducts;
  bool get getWishListInProgress => _getWishListInProgress;
  bool get wishListInProgress => _wishListInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _getWishListInProgress = true;
    _errorMessage = null;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.getWishListUrl,
    );

    if (response.isSuccess) {
      final List<ProductModel> wishList = [];
      final dynamic data = response.body['data'];
      final List<dynamic> results;

      if (data is Map<String, dynamic> && data['results'] is List) {
        results = data['results'] as List<dynamic>;
      } else if (data is List) {
        results = data;
      } else {
        results = const [];
      }

      for (final dynamic item in results) {
        if (item is! Map<String, dynamic>) {
          continue;
        }
        final dynamic rawProduct = item['product'] ?? item['productId'] ?? item;
        if (rawProduct is Map<String, dynamic> && rawProduct['_id'] != null) {
          wishList.add(ProductModel.fromJson(rawProduct));
        }
      }

      _wishListProducts = wishList;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _wishListProducts = [];
      _errorMessage = response.errorMessage;
    }

    _getWishListInProgress = false;
    notifyListeners();
    return isSuccess;
  }

  Future<bool> addWishList(String productId) async {
    bool isSuccess = false;
    _wishListInProgress = true;
    _errorMessage = null;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.getWishListUrl,
      body: {'product': productId},
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _wishListInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
