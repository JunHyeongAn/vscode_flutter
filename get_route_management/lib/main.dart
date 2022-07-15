import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MyHomePage(), popGesture: true),
        GetPage(name: '/second', page: () => const Second(), popGesture: true),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Next Screen'),
          onPressed: () => Get.toNamed(
            "/second",
            arguments: {
              "greeting": "Hello",
              "name": "World",
            },
          ),
        ),
      ),
    );
  }
}

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Get.arguments['greeting']}, ${Get.arguments['name']}"),
            TextButton(
              onPressed: () => Get.toNamed("/"),
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
