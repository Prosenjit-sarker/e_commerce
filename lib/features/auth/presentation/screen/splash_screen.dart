import 'package:crafty_bay/app/providers/language_provider.dart';
import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screen/signup_screen.dart';
import 'package:crafty_bay/features/shared/Presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool isLoggedIn = await AuthController.isIfUserLoggedIn();
    if (isLoggedIn) {
      await AuthController.getUserData();
    }

    if (!mounted) {
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? MainNavHolderScreen.name : SignupScreen.name,
    );
  }
  @override
  Widget build(BuildContext context) {
    final languageProvider = context.read<LanguageProvider>();

    return Scaffold(body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [

        Expanded(child: Center(child: AppLogo(height: 120,))),

        CircularProgressIndicator()
      ]),
    ));
  }
}
