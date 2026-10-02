import 'package:evently/core/config/app_config.dart';
import 'package:evently/core/utils/validator.dart';
import 'package:evently/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/app_assets.dart';
import '../../home/home_screen.dart';
import '../forget_password/forget_password_screen.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  AuthService authService = AuthService();

  bool isLoading = false;

  bool isPasswordObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
    var validator = Validator();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .start,
              spacing: 24,
              children: [
                Center(
                  child: Image.asset(
                    provider.thememode == ThemeMode.light
                        ? AppAssets.logoLight
                        : AppAssets.logoDark,
                    width: MediaQuery.of(context).size.width * .4,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  locale.loginToYourAccount,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: .bold),
                ),

                TextFormField(
                  controller: emailController,
                  validator: (input) => validator.emailValidator(input, locale),
                  autovalidateMode: .onUserInteraction,
                  decoration: InputDecoration(
                    hintText: locale.enterYourEmail,
                    prefixIcon: Icon(Icons.mail_outline_outlined),
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: isPasswordObscure,
                  validator: (input) =>
                      validator.passwordValidator(input, locale),
                  autovalidateMode: .onUserInteraction,
                  decoration: InputDecoration(
                    hintText: locale.enterYourPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordObscure = !isPasswordObscure;
                        });
                      },
                      icon: Icon(
                        isPasswordObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                ),

                Row(
                  mainAxisAlignment: .end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ForgetPasswordScreen.route,
                        );
                      },
                      child: Text(locale.forgotPassword),
                    ),
                  ],
                ),

                FilledButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await authService.signInWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          HomeScreen.route,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(locale.passwordTooWeak)),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(locale.accountAlreadyExists),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.surface,
                        )
                      : Text(
                          locale.login,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(color: Colors.white),
                        ),
                ),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      locale.dontHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.route);
                      },
                      child: Text(
                        locale.signUp,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(locale.or),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                OutlinedButton(
                  onPressed: () async {
                    await authService.signInWithGoogle();

                    Navigator.pushReplacementNamed(context, HomeScreen.route);
                  },
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Image.asset(AppAssets.googleLogo, scale: 1.4),
                      SizedBox(width: 16),
                      Text(locale.loginWithGoogle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
