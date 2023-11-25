import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

class DialogHelper {

  static void showImagePickerDialog({
    required BuildContext context,
    required Function(XFile?) onSelectImage,
    required Function() onRemoveImage,
  }) {
    final ImagePicker picker = ImagePicker();

    XFile? image;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.uploadImageFrom, style: AppTextStyle.interRegularBlack),
                    const Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () async {
                    GoRouter.of(context).pop();
                    image = await picker.pickImage(source: ImageSource.gallery);
                    onSelectImage(image);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.orange,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.gallery,
                            style: AppTextStyle.interSmallBoldWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () async {
                    GoRouter.of(context).pop();
                    image = await picker.pickImage(source: ImageSource.camera);
                    onSelectImage(image);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.orange,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.camera,
                            style: AppTextStyle.interSmallBoldWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
