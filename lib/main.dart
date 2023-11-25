import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/add_request/add_request_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/packages/packages_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/pay/pay_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/materials_by_type/materials_by_type_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/materials_types/materials_types_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/orders/orders_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/secret_stripe/secret_stripe_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/service_sections/service_sections_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/services_types/services_types_cubit.dart';

import 'config/routes/app_router.dart';
import 'core/services/fcm_services.dart';
import 'core/services/services_locator.dart' as di;
import 'features/presentation/blocs/info/info_bloc.dart';
import 'features/presentation/cubits/rent_contract_info/rent_contract_info_cubit.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  onDidReceiveLocalNotification(
    1,
    message.data['title'] ?? 'No title',
    message.data['body'] ?? 'No body',
    message.data,
    message: message,
  );
}

@pragma('vm:entry-point')
Future<void> onDidReceiveLocalNotification(int id, String title, String body, Map<String, dynamic> payload,
    {RemoteMessage? message}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
  const AndroidNotificationDetails('default_channel', 'Default Channel',
      channelDescription: 'This is the default channel',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launcher_icon',
      ticker: 'ticker');
  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: const DarwinNotificationDetails(),
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.show(
    1,
    title,
    body,
    platformChannelSpecifics,
    payload: jsonEncode(payload),
  );
}


Future<void> main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMServices();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Stripe.publishableKey =
  'pk_test_51M3djFBHPvC64k6fAVeDxBuO8weoiMkU5N8EC88AgaS7WrHU7JXctekwC3XSDbQfmeaxz6azd7jb76OpBTRyjrjr00fnjneyfE';
  runApp(const GulfSkyProvider());
}

class GulfSkyProvider extends StatelessWidget {
  const GulfSkyProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<InfoBloc>()),
        BlocProvider(create: (context) => di.sl<PackagesBloc>()),
        BlocProvider(create: (context) => di.sl<ServicesTypesCubit>()),
        BlocProvider(create: (context) => di.sl<ServiceSectionsCubit>()),
        BlocProvider(create: (context) => di.sl<RentContractInfoCubit>()),
        BlocProvider(create: (context) => di.sl<MaterialsTypesCubit>()),
        BlocProvider(create: (context) => di.sl<MaterialsByTypeCubit>()),
        BlocProvider(create: (context) => di.sl<AddRequestBloc>()),
        BlocProvider(create: (context) => di.sl<SecretStripeCubit>()),
        BlocProvider(create: (context) => di.sl<PayBloc>()),
        BlocProvider(create: (context) => di.sl<NotificationsCubit>()),
        BlocProvider(create: (context) => di.sl<OrdersCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Gulf Sky',
        builder: EasyLoading.init(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        locale: const Locale('ar'),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: const MaterialColor(0xFFFF5959, {
            50: Color.fromRGBO(255, 89, 89, .1),
            100: Color.fromRGBO(255, 89, 89, .2),
            200: Color.fromRGBO(255, 89, 89, .3),
            300: Color.fromRGBO(255, 89, 89, .4),
            400: Color.fromRGBO(255, 89, 89, .5),
            500: Color.fromRGBO(255, 89, 89, .6),
            600: Color.fromRGBO(255, 89, 89, .7),
            700: Color.fromRGBO(255, 89, 89, .8),
            800: Color.fromRGBO(255, 89, 89, .9),
            900: Color.fromRGBO(255, 89, 89, 1),
          }),
        ),
      ),
    );
  }
}
