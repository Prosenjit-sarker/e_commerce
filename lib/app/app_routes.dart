
import 'package:crafty_bay/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screen/signup_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screen/verify_otp_screen.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screen/splash_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    Widget widget = SizedBox();
    switch (settings.name) {
      case SplashScreen.name:
        widget = const SplashScreen();
        break;
      case SignupScreen.name:
        widget = const SignupScreen();
        break;
      case SignInScreen.name:
        widget = const SignInScreen();
        break;
      case VerifyOtpScreen.name:
        widget = const VerifyOtpScreen();
        break;




    }
    return MaterialPageRoute(builder: (contex) => widget);

  }
}