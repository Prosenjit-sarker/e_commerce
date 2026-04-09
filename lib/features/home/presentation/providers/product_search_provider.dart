import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../../product/data/models/product_model.dart';

class ProductSearchProvider extends ChangeNotifier {
  final int _pageSize = 30;
  bool _searchInProgress = false;
  bool get searchInProgress => _searchInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<bool> searchProducts(String query) async {
    bool isSuccess = false;
    _searchInProgress = true;
    _errorMessage = null;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.searchProductUrl(1, _pageSize, query),
    );

    if (response.isSuccess) {
      final dynamic data = response.body['data'];
      final List<dynamic> results;
      if (data is Map<String, dynamic> && data['results'] is List) {
        results = data['results'] as List<dynamic>;
      } else if (data is List) {
        results = data;
      } else {
        results = const [];
      }

      final List<ProductModel> fetchedProducts = [];
      for (final dynamic item in results) {
        if (item is Map<String, dynamic>) {
          fetchedProducts.add(ProductModel.fromJson(item));
        }
      }

      final normalizedQuery = query.trim().toLowerCase();
      _products = fetchedProducts
          .where(
            (product) => product.title.toLowerCase().contains(normalizedQuery),
          )
          .toList();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      _products = [];
    }

    _searchInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
