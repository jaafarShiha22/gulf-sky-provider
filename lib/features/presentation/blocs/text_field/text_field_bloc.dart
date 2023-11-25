import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../core/utils/field_validator/field_validator.dart';
import 'text_field_event.dart';
import 'text_field_state.dart';

class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  final _stateController = StreamController<TextFieldState>();

  Stream<TextFieldState> get stateStream => _stateController.stream;

  final _inputController = StreamController<String>();

  Sink<String> get inputSink => _inputController.sink;

  final FieldValidator fieldValidator;
  bool isObscure;

  TextFieldBloc({
    required this.fieldValidator, 
    this.isObscure = false,
  }) : super(const EmptyTextFieldState()) {
    final validateField = StreamTransformer<String, TextFieldState>.fromHandlers(
      handleData: (input, sink) {
        if (fieldValidator.isValid(input)) {
          sink.add(TextFieldState.valid());
        } else {
          sink.add(TextFieldState.notValid(
            fieldValidator,
          ));
        }
      },
    );
    _inputController.stream.transform(validateField).pipe(_stateController.sink);
    
    on<TogglePasswordVisibility>(
          (event, emit) async {
       if (event.isShown){
         isObscure = true;
         emit(const VisiblePasswordTextFieldSate());
       } else {
         isObscure = false;
         emit(const HiddenPasswordTextFieldSate());
       }
      },
    );
  }

  void dispose() {
    _stateController.close();
    _inputController.close();
  }
}
