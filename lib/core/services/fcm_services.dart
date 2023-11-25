import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:gulf_sky_provider/features/domain/entities/auth/auth_response_entity.dart';

class FCMServices {
  FCMServices() {
    initFCMServices();
  }

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  Future<void> initFCMServices() async {
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
    );

    if (GetIt.instance.isRegistered<AuthResponseEntity>()) {
      await FirebaseMessaging.instance.getToken().then((value) => null);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      onDidReceiveLocalNotification(
        1,
        notification?.title ?? message.data['title'] ?? 'No title',
        notification?.body ?? message.data['body'] ?? 'No body',
        message.data,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      onDidReceiveLocalNotification(
        1,
        notification?.title ?? message.data['title'] ?? 'No title',
        notification?.body ?? message.data['body'] ?? 'No body',
        message.data,
      );
    });
  }

  static Future<void> onDidReceiveLocalNotification(int id, String title, String body, Map<String, dynamic> payload,
      {RemoteMessage? message}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('default_channel', 'Default Channel',
            channelDescription: 'This is the default channel',
            importance: Importance.max,
            // actions: [
            //   AndroidNotificationAction(
            //     '1',
            //     'View task',
            //     cancelNotification: false,
            //   )
            // ],

            priority: Priority.high,
            icon: 'launcher_icon',
            ticker: 'ticker');
    // flutterLocalNotificationsPlugin
    //     ?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(_channel);
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );

    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!.show(
      1,
      title,
      body,
      platformChannelSpecifics,
      payload: jsonEncode(payload),
    );
  }
}
