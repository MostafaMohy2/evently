import 'package:evently/core/l10n/app_localizations.dart';

class Validator {
  String? nameValidator(String? input, AppLocalizations locale) {
    if (input == null) {
      return locale.invalidName;
    }
    if (input.isEmpty) {
      return locale.nameCantBeEmpty;
    }
    if (!RegExp(r"^[a-zA-Z0-9\s\-']+$").hasMatch(input)) {
      return locale.nameisinInvalidFormat;
    }
    return null;
  }

  String? emailValidator(String? input, AppLocalizations locale) {
    if (input == null) {
      return locale.invalidEmail;
    }
    if (input.isEmpty) {
      return locale.emailCantBeEmpty;
    }
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(input)) {
      return locale.emailIsInInvalidFormat;
    }
    return null;
  }

  String? passwordValidator(String? input, AppLocalizations locale) {
    if (input == null) {
      return locale.invalidPassword;
    }
    if (input.isEmpty) {
      return locale.passwordCantBeEmpty;
    }
    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(input)) {
      return locale.passwordIsInInvalidFormat;
    }
    return null;
  }

  String? passwordConfirmaitonValidator(
    String? input,
    String password,
    AppLocalizations locale,
  ) {
    if (input == null) {
      return locale.invalidPasswordConfirmation;
    }
    if (input.isEmpty) {
      return locale.passwordConfirmationCantBeEmpty;
    }
    if (input != password) {
      return locale.passwordsDoNotMatch;
    }
    return null;
  }
}
