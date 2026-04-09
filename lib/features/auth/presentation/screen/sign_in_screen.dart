import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/Presentation/Utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/Presentation/screens/main_nav_holder_screen.dart';
import '../../../shared/Presentation/widgets/snack_bar_message.dart';
import '../provider/sign_in_provider.dart';

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

  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signInProvider,
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
                    const SizedBox(height: 48),
                    AppLogo(),
                    const SizedBox(height: 24),
                    Text(context.l10n.welcomeBack, style: context.textTheme.titleLarge),
                    Text(
                      context.l10n.signInWithEmailAndPassword,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: context.l10n.email),
                      validator: (String? value) =>
                          Validators.validateEmail(value, context.l10n.emailRequired),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(hintText: context.l10n.password),
                      validator: (String? value) =>
                          Validators.validatePassword(value),
                    ),
                    const SizedBox(height: 16),

                    Consumer<SignInProvider>(
                      builder: (context, signInProvider, __) {
                        if (signInProvider.signInProgress) {
                          return const CircularProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapSignInButton,
                          child: Text(context.l10n.signIn),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _onTapSignUnButton,
                      child: Text(context.l10n.needAccountSignUp),
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

  Future<void> _onTapSignInButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await _signInProvider.signIn(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
      );
      if (!mounted) {
        return;
      }
      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainNavHolderScreen.name,
          (_) => false,
        );
      } else {
        showSnackBarMessage(context, _signInProvider.errorMessage!);
      }
    }
  }

  void _onTapSignUnButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _signInProvider.dispose();

    super.dispose();
  }
}
