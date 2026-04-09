import 'package:crafty_bay/app/network_caller_set_up.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:flutter/cupertino.dart';
import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../data/models/user_model.dart';

class SignInProvider extends ChangeNotifier {
  bool _signInProgress = false;
  bool get signInProgress => _signInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn({required String email, required String password}) async {
    _signInProgress = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final NetworkResponse response = await getNetworkCaller().postRequest(
        Urls.logInUrl,
        body: {
          "email": email,
          "password": password,
        },
        isFromLogin: true,
      );

      if (response.isSuccess) {
        final UserModel userModel = UserModel.fromJson(
          response.body['data']['user'],
        );
        final String token = response.body['data']['token'];
        await AuthController.saveUserData(token, userModel);
        return true;
      }

      _errorMessage = response.errorMessage;
      return false;
    } catch (e) {
      _errorMessage = 'Login failed. Please try again.';
      return false;
    } finally {
      _signInProgress = false;
      notifyListeners();
    }
  }
}
