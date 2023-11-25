import 'package:gulf_sky_provider/core/utils/field_validator/field_validator.dart';

abstract class TextFieldState{

  factory TextFieldState.empty() = EmptyTextFieldState;

  factory TextFieldState.valid() = ValidTextFieldState;

  factory TextFieldState.notValid(FieldValidator validator) = NotValidTextFieldState;

}

class EmptyTextFieldState implements TextFieldState {

  const EmptyTextFieldState();
}

class ValidTextFieldState implements TextFieldState {

  const ValidTextFieldState();
}

class NotValidTextFieldState implements TextFieldState {
  final FieldValidator fieldValidator;

  const NotValidTextFieldState(this.fieldValidator);
}

class VisiblePasswordTextFieldSate implements TextFieldState{
  const VisiblePasswordTextFieldSate();
}

class HiddenPasswordTextFieldSate implements TextFieldState{
  const HiddenPasswordTextFieldSate();
}