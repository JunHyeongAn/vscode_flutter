// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:http/http.dart' as http;

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
Future initNotification() async {
  //안드로이드용 아이콘파일 이름
  //안드로이드 아이콘 경로 : android/app/src/main/res/drawable/app.icon.png
  var androidSetting = AndroidInitializationSettings('app_icon');

  //ios에서 앱 로드시 유저에게 권한요청하려면
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(
    initializationSettings,
    //알림 누를때 함수실행하고 싶으면
    onSelectNotification: (payload) {
      print("payload : $payload");
    },
  );
}

Future showNotification(
  String channelId,
  String description,
  int notificationIdx,
  String? title,
  String? body,
  //String? image,
) async {
  var androidDetails = AndroidNotificationDetails(
    //유니크한 알림 채널 ID
    channelId,
    //알림종류 설명
    description,
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(
    1, title, body,
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    payload: '부가정보', // 부가정보
  );
}

// duration초 뒤에 알림 보냄
Future showNotificationDelayTime(
  String channelId,
  String description,
  int notificationIdx,
  String title,
  String body,
  int duration,
) async {
  var androidDetails = AndroidNotificationDetails(
    //유니크한 알림 채널 ID
    channelId,
    //알림종류 설명
    description,
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.zonedSchedule(
    notificationIdx,
    title,
    body,
    TZDateTime.now(local).add(Duration(seconds: duration)),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

// 주기적으로 알람을 보낸다
Future showNotificationSchaduled(
  String channelId,
  String description,
  int notificationIdx,
  String title,
  String body,
  int duration,
) async {
  var androidDetails = AndroidNotificationDetails(
    //유니크한 알림 채널 ID
    channelId,
    //알림종류 설명
    description,
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.zonedSchedule(
    notificationIdx,
    title,
    body,
    TZDateTime.now(local).add(Duration(seconds: 5)),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,

    // 주기적으로 알림을 보낸다
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

// 특정 시간마다 알람을 보냄
Future showNotificationOnTime(
  String channelId,
  String description,
  int notificationIdx,
  String title,
  String body,
  int duration,
) async {
  var androidDetails = AndroidNotificationDetails(
    //유니크한 알림 채널 ID
    channelId,
    //알림종류 설명
    description,
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.zonedSchedule(
    notificationIdx,
    title,
    body,

    // 매일 7시에 알람을 보냄
    makeDate(7, 0, 0),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,

    // 주기적으로 알림을 보낸다
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

Future<void> showBigPictureNotificationURL(
  String bigImage,
  int notificationIdx,
  String? title,
  String? body,
) async {
  final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl('https://via.placeholder.com/48x48'));
  final ByteArrayAndroidBitmap bigPicture =
      // 400 x 800
      ByteArrayAndroidBitmap(await _getByteArrayFromUrl(bigImage));

  final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(
    bigPicture,
    largeIcon: largeIcon,
    contentTitle: title,
    htmlFormatContentTitle: true,
    summaryText: body,
    htmlFormatSummaryText: true,
  );
  final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('big text channel id', 'big text channel name',
          channelDescription: 'big text channel description',
          styleInformation: bigPictureStyleInformation);
  final NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await notifications.show(
    notificationIdx,
    title,
    body,
    notificationDetails,
  );
}

// 시간 만들어주는 함수
makeDate(hour, min, sec) {
  var now = TZDateTime.now(local);
  var when = TZDateTime(local, now.year, now.month, now.day, hour, min, sec);
  if (when.isBefore(now)) {
    return when.add(Duration(days: 1));
  } else {
    return when;
  }
}
