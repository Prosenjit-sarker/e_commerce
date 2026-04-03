import 'package:crafty_bay/app/network_caller_set_up.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../data/models/user_model.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _verifyOtpInProgress = false;

  bool get verifyOtpInProgress => _verifyOtpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp({required String email, required String otp}) async {
    bool isSuccess = false;
    _verifyOtpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.verifyOtp,
      body: {
        "email": email,
        "otp": otp,
      },
    );

    if (response.isSuccess) {
      // user model save to local storage
      UserModel userModel = UserModel.fromJson(response.body['data']['user']);
      String token = response.body['data']['token'];
      await AuthController.saveUserData(token, userModel);




      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _verifyOtpInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
