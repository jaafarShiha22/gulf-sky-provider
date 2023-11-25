import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

class ToastUtils{
  static showToast(String errorMsg) => Fluttertoast.showToast(
  msg: errorMsg,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  backgroundColor: AppColors.orange.withOpacity(.8),
  textColor: AppColors.white,
  fontSize: 16.0,
  );
}