import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> playRingtone() async {
  await FlutterRingtonePlayer.play(
    android: AndroidSounds.notification,
    ios: IosSounds.glass,
    looping: false,
    volume: 0.5,
    asAlarm: false,
  );
}

Future<void> _onBackgroundNotification(RemoteMessage message) async {
  await HapticFeedback.mediumImpact();
  await playRingtone();
  return;
}

class NotificationsManager {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('ngbuka_logo');

  static DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: "This channel is used for important notifications.",
    importance: Importance.high,
    playSound: true,
  );
  static Future<String?> getFcmToken() {
    return _firebaseMessaging.getToken();
  }

  static Future<void> requestPermissions() async {
    final messaging = FirebaseMessaging.instance;
    //requests permissions for notifications
    await [Permission.notification].request();

    await messaging.requestPermission(
      announcement: true,
    );
  }

  /// init the messaging service
  static Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.setAutoInitEnabled(true);
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onBackgroundNotification(message);
      if (message.notification != null) {
        RemoteNotification notification = message.notification!;
        AndroidNotification? android = message.notification?.android;
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android?.smallIcon,
              priority: Priority.high,
              playSound: channel.playSound,
            ),
            iOS: const DarwinNotificationDetails(
              presentSound: true,
              presentAlert: true,
              presentBadge: true,
              presentList: true,
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('remote message is $message');
      if (message.notification != null) {
        RemoteNotification notification = message.notification!;
        AndroidNotification? android = message.notification?.android;
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android?.smallIcon,
              priority: Priority.high,
              playSound: channel.playSound,
            ),
            iOS: const DarwinNotificationDetails(
              presentSound: true,
              presentAlert: true,
              presentBadge: true,
              presentList: true,
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onBackgroundMessage(_onBackgroundNotification);
  }
}
