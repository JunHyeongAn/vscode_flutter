import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_cat_v2/model/like_model.dart';
import 'package:random_cat_v2/widgets/home/Home.dart';
import 'package:random_cat_v2/widgets/image_detail/image_detail.dart';
import 'package:random_cat_v2/widgets/login/Login.dart';

void main() async {
  // to hide only bottom bar
  await Hive.initFlutter();
  Hive.registerAdapter(LikeAdapter());
  await Hive.openBox('likecat');

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug:
          true // optional: set to false to disable printing logs to console (default: true)
      // ignoreSsl: true // option: set to false to disable working with http links (default: false)
      );
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
        GetPage(
          name: "/image",
          page: () => const ImageDetail(),
          popGesture: true,
        ),
        GetPage(
          name: "/login",
          page: () => const Login(),
          popGesture: true,
        ),
      ],
    );
  }
}
