import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/category_model.dart';

class CategoryListProvider extends ChangeNotifier {
  final int _pageSize = 30;

  int _currentPageNo = 0;

  int? _lastPage;

  bool _getInitialCategoryListInProgress = true;

  bool _loadMoreCategoryListInProgress = true;

  List<CategoryModel> _categories = [];

  bool get getInitialCategoryListInProgress =>
      _getInitialCategoryListInProgress;

  bool get loadMoreCategoryListInProgress => _loadMoreCategoryListInProgress;

  List<CategoryModel> get categories => _categories;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<bool> getCategories() async {
    bool isSuccess = false;
    if (_lastPage != null && _currentPageNo >= _lastPage!) {
      return false;
    }
    _currentPageNo++;
    if (_isInitialLoading) {
      _getInitialCategoryListInProgress = true;
    } else {
      _loadMoreCategoryListInProgress = true;
    }
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.categoryListUrl(_currentPageNo, _pageSize),
    );
    if (response.isSuccess) {
      _lastPage = response.body['data']['last_page'] ?? _lastPage;
      List<CategoryModel> categories = [];
      for (Map<String, dynamic> category in response.body['data']['results']) {
        categories.add(CategoryModel.fromJson(category));
      }
      _categories.addAll(categories);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    if (_isInitialLoading) {
      _getInitialCategoryListInProgress = false;
    } else {
      _loadMoreCategoryListInProgress = false;
    }
    notifyListeners();
    return isSuccess;
  }

  bool get _isInitialLoading {
    return _currentPageNo == 1;
  }
}
