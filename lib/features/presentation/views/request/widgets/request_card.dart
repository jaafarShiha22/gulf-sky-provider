import 'package:flutter/material.dart';
import 'package:gulf_sky_provider/core/utils/app_colors.dart';
import 'package:gulf_sky_provider/core/utils/app_text_style.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final void Function() onTap;

  const RequestCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width /1,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(
                      iconData,
                      color: AppColors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: AppTextStyle.interRegularBoldWhite.copyWith(color: AppColors.orange),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
