
import 'package:equatable/equatable.dart';

abstract class TextFieldEvent extends Equatable {
  const TextFieldEvent();

  @override
  List<Object> get props => [];
}

class CheckFieldValidation extends TextFieldEvent {
  final String input;
  const CheckFieldValidation({
    required this.input,
});

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibility extends TextFieldEvent {
  final bool isShown;
  const TogglePasswordVisibility({
    required this.isShown,
  });

  @override
  List<Object> get props => [];
}

