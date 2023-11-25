import 'package:flutter/material.dart';

import '../../../core/utils/app_text_style.dart';

class CustomRoundedButton extends StatelessWidget {
  final String label;
  final Color color;
  final void Function() onPressed;

  const CustomRoundedButton({
    Key? key,
    required this.label,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(
              double.infinity,
              50,
            ),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Text(
          label,
          style: AppTextStyle.interRegularBoldWhite,
        ),
      ),
    );
  }
}
