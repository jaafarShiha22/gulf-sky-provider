import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets_data.dart';
import '../../../domain/entities/auth/auth_response_entity.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  @override
  void initState() {
    navigateToOnboardingView();
    super.initState();
  }

  Future<void> navigateToOnboardingView() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    await SharedPreferences.getInstance().then((prefs) async {
      if (prefs.getString('user') == null) {
        GoRouter.of(context).pushReplacement(
          AppRoutes.loginView,
        );
      } else {
        String userJSon = prefs.getString('user')!;
        AuthResponseEntity authResponseEntity = AuthResponseEntity.fromMap(jsonDecode(userJSon));
        GetIt.instance.registerLazySingleton<AuthResponseEntity>(() => authResponseEntity);
        GoRouter.of(context).pushReplacement(
          AppRoutes.mainView,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(
              AssetsData.logo,
            ),
          ),
        ),
      ),
    );
  }
}
