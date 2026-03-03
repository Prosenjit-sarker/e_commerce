import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/Presentation/Utils/validators.dart';
import 'package:flutter/material.dart';

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
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) =>
                        Validators.validateEmail(value, 'Email is required'),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? value) => Validators.validateText(
                      value,
                      'First name is required',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value) =>
                        Validators.validateText(value, 'Last name is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Phone'),
                    validator: (String? value) =>
                        Validators.validateText(value, 'Phone is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'City'),
                    validator: (String? value) =>
                        Validators.validateText(value, 'City is required'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) =>
                        Validators.validatePassword(value),
                  ),
                  const SizedBox(height: 16),

                  FilledButton(
                    onPressed: _onTapSignUpButton,
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {

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
