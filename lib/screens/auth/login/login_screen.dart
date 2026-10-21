import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:evently/core/utils/validator.dart';
import 'package:evently/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    final provider = context.appConfig;
    final locale = context.locale;
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
                    width: context.screenWidth * .4,
                  ),
                ),

                16.verticalSpace,

                Text(
                  locale.loginToYourAccount,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: .bold,
                  ),
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
                        context.pushNamed(ForgetPasswordScreen.route);
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
                        if (!mounted) return;
                        context.pushReplacementNamed(HomeScreen.route);
                      } on FirebaseAuthException catch (e) {
                        if (!mounted) return;
                        if (e.code == 'weak-password') {
                          context.showSnackBar(
                            SnackBar(content: Text(locale.passwordTooWeak)),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          context.showSnackBar(
                            SnackBar(
                              content: Text(locale.accountAlreadyExists),
                            ),
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
                        context.showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: context.colorScheme.surface,
                        )
                      : Text(
                          locale.login,
                          style: context.textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      locale.dontHaveAnAccount,
                      style: context.textTheme.bodyLarge,
                    ),

                    TextButton(
                      onPressed: () {
                        context.pushNamed(SignupScreen.route);
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
                    if (!mounted) return;
                    context.pushReplacementNamed(HomeScreen.route);
                  },
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Image.asset(AppAssets.googleLogo, scale: 1.4),
                      16.horizontalSpace,
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
