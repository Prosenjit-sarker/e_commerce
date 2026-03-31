import 'package:crafty_bay/app/crafty_bay_app.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: {
      'token': 'token',
      'Content-Type': 'application/json',
    }, onUnauthorize: () {
      // Handle unauthorize
    _moveToSignInScreen();
  },
  );
}

void _moveToSignInScreen(){
  Navigator.pushNamed(CraftyBayApp.navigatorKey.currentContext!, SignInScreen.name);
}