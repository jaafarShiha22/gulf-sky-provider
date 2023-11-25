import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:gulf_sky_provider/config/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/services_locator.dart' as di;
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.info,
                    backgroundColor: AppColors.orange,
                    text: AppLocalizations.of(context)!.areYouSureYouWantToLogout,
                    title: AppLocalizations.of(context)!.confirm,
                    showCancelBtn: true,
                    cancelBtnText: AppLocalizations.of(context)!.no,
                    cancelBtnTextStyle: AppTextStyle.interSmallBoldOrange,
                    onCancelBtnTap: () {},
                    confirmBtnText: AppLocalizations.of(context)!.yes,
                    confirmBtnTextStyle: AppTextStyle.interSmallBoldWhite,
                    onConfirmBtnTap: () async {
                      EasyLoading.show(status: AppLocalizations.of(context)!.loading);
                      await GetIt.instance.reset();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      await di.init().then((value) {
                        EasyLoading.dismiss();
                        GoRouter.of(context).pushReplacement(AppRoutes.loginView);
                      });
                    },
                    confirmBtnColor: AppColors.orange,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: AppColors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.logout,
                          style: AppTextStyle.interRegularBoldWhite.copyWith(color: AppColors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.contact_support_outlined,
                          color: AppColors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.contactUs,
                          style: AppTextStyle.interRegularBoldWhite.copyWith(color: AppColors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
