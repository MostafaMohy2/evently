import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/validator.dart';
import 'package:evently/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../../home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String route = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  AuthService authService = AuthService();

  bool isLoading = false;

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
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

                SizedBox(height: 16),

                Text(
                  locale.createYourAccount,
                  style: context.textTheme.titleLarge!.copyWith(fontWeight: .bold),
                ),

                TextFormField(
                  controller: nameController,
                  validator: (input) => validator.nameValidator(input, locale),
                  autovalidateMode: .onUserInteraction,
                  decoration: InputDecoration(
                    hintText: locale.enterYourName,
                    prefixIcon: Icon(Icons.person_outline),
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
                TextFormField(
                  controller: passwordConfirmController,
                  obscureText: isConfirmPasswordObscure,
                  validator: (input) => validator.passwordConfirmaitonValidator(
                    input,
                    passwordController.text,
                    locale,
                  ),
                  autovalidateMode: .onUserInteraction,
                  decoration: InputDecoration(
                    hintText: locale.confirmYourPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordObscure = !isConfirmPasswordObscure;
                        });
                      },
                      icon: Icon(
                        isConfirmPasswordObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                ),

                FilledButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await authService.createAccountWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                        );
                        if (!mounted) return;
                        context.showSnackBar(
                          SnackBar(
                            content: Text(locale.accountCreatedSuccessfully),
                          ),
                        );
                        context.pop();
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
                        context.showSnackBar(SnackBar(content: Text(e.toString())));
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
                          locale.signUp,
                          style: context.textTheme.titleLarge!.copyWith(color: Colors.white),
                        ),
                ),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      locale.alreadyHaveAnAccount,
                      style: context.textTheme.bodyLarge,
                    ),

                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(locale.login, style: TextStyle(fontSize: 16)),
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
                      SizedBox(width: 16),
                      Text(locale.signUpWithGoogle),
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
