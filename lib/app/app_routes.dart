
import 'package:crafty_bay/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screen/signup_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screen/verify_otp_screen.dart';
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/shared/Presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screen/splash_screen.dart';
import '../features/product/presentation/screens/product_details_screen.dart';
import '../features/product/presentation/screens/product_list_screen.dart';
import '../features/reviews/presentations/screens/review_screen.dart';

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
        final email = settings.arguments as String;
        widget =  VerifyOtpScreen(email: email);
        break;
      case MainNavHolderScreen.name:
        widget = const MainNavHolderScreen();
        break;
      case ProductListScreen.name:
        final category = settings.arguments as CategoryModel;
        widget =  ProductListScreen(category: category,);
        break;
      case ProductDetailsScreen.name:
        widget = const ProductDetailsScreen();
        break;
      case ReviewScreen.name:
        widget = const ReviewScreen();
        break;





    }
    return MaterialPageRoute(builder: (contex) => widget);

  }
}