import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/core/utils/app_text_style.dart';

import '../../../../core/utils/field_validator/field_validator.dart';
import 'app_text_field.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final FieldValidator fieldValidator;
  final int? maxLines;
  final String fieldLabel;
  final double? fieldHeight;
  final bool enabled;
  final bool isRequired;

  const LabeledTextField({
    Key? key,
    required this.label,
    required this.textEditingController,
    required this.fieldValidator,
    this.fieldHeight,
    this.isRequired = false,
    this.fieldLabel = '',
    this.maxLines,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: AppTextStyle.interSmallBoldBlack),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: fieldHeight,
            child: AppTextField(
              key: Key(label),
              label: fieldLabel,
              padding:  EdgeInsets.zero,
              controller: textEditingController,
              fieldValidator: fieldValidator,
              maxLines: maxLines,
            ),
          ),
        ],
      ),
    );
  }
}
