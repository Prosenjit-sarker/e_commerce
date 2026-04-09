import 'package:crafty_bay/features/product/data/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class AddToCartProvider extends ChangeNotifier {
  bool _addToCartInProgress = false;
  bool get addToCartInProgress => _addToCartInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(AddToCartModel params) async {
    bool isSuccess = false;
    _addToCartInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.addToCartUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _addToCartInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
