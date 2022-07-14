import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_practicce/notification.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initNotification();
  String? token = await messaging.getToken();

  FirebaseMessaging.onMessage.listen((RemoteMessage rm) {
    String image = rm.data["image"] ?? "";
    String? title = rm.notification!.title;
    String? body = rm.notification!.body;

    if (image.isNotEmpty) {
      showBigPictureNotificationURL(
        image,
        1,
        title,
        body,
      );
    } else {
      showNotification(
        "channelId",
        "description",
        1,
        title,
        body,
      );
    }
  });
  print(token);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
