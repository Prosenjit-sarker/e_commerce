import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_params.dart';
import 'package:crafty_bay/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screen/verify_otp_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/Presentation/Utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/Presentation/widgets/snack_bar_message.dart';
import '../provider/sign_up_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String name = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignUpProvider _signUpProvider = SignUpProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signUpProvider,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    AppLogo(),
                    const SizedBox(height: 24),
                    Text(
                      'Sign Up With Email',
                      style: context.textTheme.titleLarge,
                    ),
                    Text(
                      'Get Started With Your details',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String? value) =>
                          Validators.validateEmail(value, 'Email is required'),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (String? value) => Validators.validateText(
                        value,
                        'First name is required',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) => Validators.validateText(
                        value,
                        'Last name is required',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneTEController,
                      decoration: InputDecoration(hintText: 'Phone'),
                      validator: (String? value) =>
                          Validators.validateText(value, 'Phone is required'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _cityTEController,
                      decoration: InputDecoration(hintText: 'City'),
                      validator: (String? value) =>
                          Validators.validateText(value, 'City is required'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String? value) =>
                          Validators.validatePassword(value),
                    ),
                    const SizedBox(height: 16),

                    Consumer<SignUpProvider>(
                      builder: (context, signUpProvider, _) {
                        if (signUpProvider.signUpInProgress) {
                          return const CircularProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapSignUpButton,
                          child: Text('Sign Up'),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _onTapSignINButton,
                      child: Text('Already have an account? Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    SignUpParams params = SignUpParams(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      email: _emailTEController.text.trim(),
      phone: _phoneTEController.text.trim(),
      city: _cityTEController.text.trim(),
      password: _passwordTEController.text,
    );
    final bool isSuccess = await _signUpProvider.signUp(params);
    if (isSuccess) {
      Navigator.pushNamed(context, VerifyOtpScreen.name);
    } else {
      showSnackBarMessage(context, _signUpProvider.errorMessage!);
    }
  }

  void _onTapSignINButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
