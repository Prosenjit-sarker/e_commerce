import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/Presentation/Utils/validators.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  AppLogo(),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome Back',
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    'Sign in with your email and password',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) =>
                        Validators.validateEmail(value, 'Email is required'),
                  ),

                  const SizedBox(height: 8),


                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) =>
                        Validators.validatePassword(value),
                  ),
                  const SizedBox(height: 16),

                  FilledButton(
                    onPressed: _onTapSignInButton,
                    child: Text('Sign In'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _onTapSignUnButton,
                    child: Text('Need an account? Sign Un'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {}
  void _onTapSignUnButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();


    super.dispose();
  }
}
