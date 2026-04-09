import 'package:flutter/cupertino.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/product_details_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool _getProductDataInProgress = false;
  bool get getProductDataInProgress => _getProductDataInProgress;

  ProductDetailsModel? _productDetailsModel;
  ProductDetailsModel? get productDetailsModel => _productDetailsModel;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(String productId) async {
    bool isSuccess = false;

    _getProductDataInProgress = true;
    _errorMessage = null;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.productDetailsUrl(productId),
    );

    if (response.isSuccess) {
      _productDetailsModel = ProductDetailsModel.fromJson(
        response.body['data'],
      );
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getProductDataInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
