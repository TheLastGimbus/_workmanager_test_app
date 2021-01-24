import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void initialize() {
  final plugin = FlutterLocalNotificationsPlugin();
  final android = AndroidInitializationSettings('app_icon');
  final settings = InitializationSettings(android: android);
  plugin.initialize(settings);
}

Future<void> sendNotification(String text) =>
    FlutterLocalNotificationsPlugin().show(
      Random().nextInt(100000),
      'Background stuff',
      text,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'Background notifications',
          'Notifs in bgnd',
        ),
      ),
    );
