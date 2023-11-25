import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../enums/field_error.dart';
import '../field_validator/field_validator.dart';

extension FieldErrorMessage on FieldValidator{
  String getErrorMessage(BuildContext context){
    switch(getErrorMessageType()) {
      case FieldError.fieldShouldNotBeEmpty:
        return AppLocalizations.of(context)!.fieldShouldNotBeEmpty;
      case FieldError.emailNotValid:
        return AppLocalizations.of(context)!.emailNotValid;
      case FieldError.onlyNumbers:
        return AppLocalizations.of(context)!.pleaseEnterNumbersOnly;
      default:
        return AppLocalizations.of(context)!.fieldShouldNotBeEmpty;
    }

  }
}