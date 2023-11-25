import 'package:email_validator/email_validator.dart';

import '../enums/field_error.dart';

abstract class FieldValidator {
  bool isValid(String input);

  static EmailFieldValidator email = EmailFieldValidator._();
  static NotEmptyFieldValidator notEmpty = NotEmptyFieldValidator._();
  static PasswordFieldValidator password = PasswordFieldValidator._();
  static OnlyDigitFieldValidator onlyDigits = OnlyDigitFieldValidator._();
  static NoFieldValidator none = NoFieldValidator._();

  FieldError getErrorMessageType();
}

class NotEmptyFieldValidator implements FieldValidator {
  NotEmptyFieldValidator._();

  @override
  bool isValid(String input) => input.isNotEmpty;

  @override
  FieldError getErrorMessageType() => FieldError.fieldShouldNotBeEmpty;//AppLocalizations.of(context)!.pleaseFillNameField
}


class PasswordFieldValidator implements FieldValidator {
  PasswordFieldValidator._();

  @override
  bool isValid(String input) => input.isNotEmpty;

  @override
  FieldError getErrorMessageType() => FieldError.fieldShouldNotBeEmpty;
}

class EmailFieldValidator implements FieldValidator {
  EmailFieldValidator._();

  @override
  bool isValid(String input) => EmailValidator.validate(input);

  @override
  FieldError getErrorMessageType() => FieldError.emailNotValid;//AppLocalizations.of(context)!.emailNotValid;
}

class OnlyDigitFieldValidator implements FieldValidator {
  OnlyDigitFieldValidator._();

  @override
  bool isValid(String input) => RegExp(r'^\d+$').hasMatch(input);

  @override
  FieldError getErrorMessageType() => FieldError.onlyNumbers;//AppLocalizations.of(context)!.pleaseEnterNumbersOnly;
}

class NoFieldValidator implements FieldValidator {
  NoFieldValidator._();

  @override
  bool isValid(String input) => true;

  @override
  FieldError getErrorMessageType() => FieldError.none;
}
