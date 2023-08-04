import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails? notificationDetails;

  void requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission Granted');
      print("granted automatically");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Provisional permissions granted');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('DENIED');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      print(event.toString());
    });
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSetting = DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iosInitializationSetting,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  void FirebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      if (Platform.isAndroid) {
        initLocalNotification(context,event);
        showNotification(event);
      }
      ;
    });
  }

  void showNotification(RemoteMessage message) {
    setNotificationDetails();
    Future.delayed(Duration(seconds: 0),(){
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<void> setNotificationDetails() async{
    AndroidNotificationChannel channle = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      // 1.toString(),
      "High Importance Notification",
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channle.id.toString(),
      channle.name.toString(),
      channelDescription: "DreamNet Android Notification Channel",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );
    notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
  }
}
