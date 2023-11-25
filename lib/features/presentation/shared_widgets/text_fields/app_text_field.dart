import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulf_sky_provider/core/utils/extensions/field_error_message.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/field_validator/field_validator.dart';
import '../../blocs/text_field/text_field_bloc.dart';
import '../../blocs/text_field/text_field_event.dart';
import '../../blocs/text_field/text_field_state.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget? suffixIcon;
  final Color borderColor;
  final FieldValidator fieldValidator;
  final Color filledColor;
  final int? maxLines;
  final EdgeInsets? padding;
  final bool withBorders;
  final bool enabled;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.fieldValidator,
    this.suffixIcon,
    this.withBorders = true,
    this.enabled = true,
    this.padding = const EdgeInsets.only(bottom: 20.0),
    this.maxLines = 1,
    this.borderColor = Colors.transparent,
    this.filledColor = AppColors.lightGrey,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextFieldBloc _bloc;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = TextFieldBloc(
      fieldValidator: widget.fieldValidator,
      isObscure: widget.fieldValidator is PasswordFieldValidator ? true : false,
    );
    return BlocBuilder<TextFieldBloc, TextFieldState>(
      bloc: _bloc,
      builder: (context, state) {
        return Padding(
          padding: widget.padding!,
          child: StreamBuilder<TextFieldState>(
            stream: _bloc.stateStream,
            initialData: const EmptyTextFieldState(),
            builder: (context, snapshot) {
              return TextFormField(
                controller: widget.controller,
                obscureText: _bloc.isObscure,enabled: widget.enabled,
                maxLines: widget.maxLines,
                keyboardType: widget.fieldValidator is EmailFieldValidator ? TextInputType.emailAddress : TextInputType.text,
                decoration: InputDecoration(
                  hintText: widget.label,
                  filled: true,
                  fillColor: widget.filledColor,
                  border: widget.withBorders
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: widget.borderColor,
                          ),
                        )
                      : InputBorder.none,
                  enabledBorder: widget.withBorders
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: widget.borderColor,
                          ),
                        )
                      : InputBorder.none,
                  disabledBorder:  widget.withBorders
                      ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                    ),
                  )
                      : InputBorder.none,
                  suffixIcon: (widget.fieldValidator is PasswordFieldValidator)
                      ? GestureDetector(
                          onTap: () {
                            _bloc.add(
                              TogglePasswordVisibility(
                                isShown: !_bloc.isObscure,
                              ),
                            );
                          },
                          child: Icon(
                            _bloc.isObscure ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                            color: AppColors.black,
                          ),
                        )
                      : widget.suffixIcon,
                ),
                onChanged: (value) {
                  _bloc.inputSink.add(value);
                },
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (snapshot.data is NotValidTextFieldState) {
                    NotValidTextFieldState state = snapshot.data as NotValidTextFieldState;
                    return state.fieldValidator.getErrorMessage(context);
                  }
                  return null;
                },
              );
            },
          ),
        );
      },
    );
  }
}
