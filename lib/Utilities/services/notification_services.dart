import 'dart:io';
import 'dart:math';
// import 'package:timezone/data/latest.dart' as tz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
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
        initLocalNotification(context, event);
        showNotification(event);
      }
      ;
    });
  }

  void showNotification(RemoteMessage message) {
    setNotificationDetails();
    Future.delayed(Duration(seconds: 0), () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<void> showSheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime sheduledTime}) async {

    await setNotificationDetails();
    _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
       tz.TZDateTime.from(sheduledTime, tz.local),
        notificationDetails!,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );

  }

  Future<void> setNotificationDetails() async {
    AndroidNotificationChannel channle = AndroidNotificationChannel(
      1.toString(),
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

  Future<void> fetchDataAndScheduleNotifications() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('users').get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        DateTime endDate = data['pkgEndDate'].toDate();
        if (endDate.isAfter(DateTime.now()) &&
            endDate.difference(DateTime.now()).inDays <= 1) {
          // String billTitle = data['billTitle'];
          String notificationTitle = 'Reminder: Pay Your Bill';
          String notificationBody = 'You have a bill due for';
          showSheduleNotification(
            sheduledTime: endDate,
            title: notificationTitle,
            body: notificationBody,
          );
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

}
