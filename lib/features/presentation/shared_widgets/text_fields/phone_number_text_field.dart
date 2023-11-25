import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/core/utils/extensions/field_error_message.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/field_validator/field_validator.dart';
import '../../blocs/text_field/text_field_bloc.dart';
import '../../blocs/text_field/text_field_state.dart';

class PhoneNumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChangeCountryCode;

  const PhoneNumberTextField({
    Key? key,
    required this.controller,
    required this.onChangeCountryCode,
  }) : super(key: key);

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  late TextFieldBloc _bloc;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = TextFieldBloc(
      fieldValidator: FieldValidator.onlyDigits,
      isObscure: false,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StreamBuilder(
        stream: _bloc.stateStream,
        initialData: const EmptyTextFieldState(),
        builder: (context, snapshot) {
          return BlocBuilder<TextFieldBloc, TextFieldState>(
            bloc: _bloc,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          onChanged: (countryCode) => widget.onChangeCountryCode(countryCode.dialCode!),
                          initialSelection: '+966',
                          favorite: const ['+966'],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: TextFormField(
                              controller: widget.controller,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _bloc.inputSink.add(value);
                              },
                              autovalidateMode: AutovalidateMode.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (snapshot.data is NotValidTextFieldState)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 8),
                      child: Text(
                        FieldValidator.notEmpty.getErrorMessage(context),
                        style: AppTextStyle.interSmallBoldBlack,
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
