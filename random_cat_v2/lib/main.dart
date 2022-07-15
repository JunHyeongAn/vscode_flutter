import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/widgets/home/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => const Home(),
          popGesture: true,
        ),
      ],
    );
  }
}
