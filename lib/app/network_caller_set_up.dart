import 'package:crafty_bay/app/crafty_bay_app.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';

import 'controllers/auth_controller.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () {
      Map<String, String> headers =  {
        'Content-Type': 'application/json',
      };
      if (AuthController.token != null) {
        headers['token'] = ' ${AuthController.token}';
      }
      return headers;
    },
    onUnauthorize: () async {
      await AuthController.clearUserData();
      _moveToSignInScreen();
    },
  );
}

void _moveToSignInScreen() {
  Navigator.pushNamed(
    CraftyBayApp.navigatorKey.currentContext!,
    SignInScreen.name,
  );
}
