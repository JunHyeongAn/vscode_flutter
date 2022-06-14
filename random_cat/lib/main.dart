import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // main() 함수에서 async를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();

  // shared_preferences 인스턴스 생성
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatService(prefs)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 고양이 서비스
class CatService extends ChangeNotifier {
  // 고양이 사진 담을 변수
  List<String> catImages = [];

  // 좋아한 사진
  List<String> favoriteCatImages = [];

  SharedPreferences prefs;

  CatService(this.prefs) {
    favoriteCatImages = prefs.getStringList("favorites") ?? [];
    getRandomCatImages();
  }

  void getRandomCatImages() async {
    String limit = "10";
    String mimeType = "jpg";
    Response result = await Dio().get(
        "https://api.thecatapi.com/v1/images/search?" +
            "limit=$limit&mime_types=$mimeType");
    for (var i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      catImages.add(map["url"]);
    }
    notifyListeners();
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteCatImages.contains(catImage)) {
      favoriteCatImages.remove(catImage);
    } else {
      favoriteCatImages.add(catImage);
    }
    prefs.setStringList("favorites", favoriteCatImages);
    notifyListeners();
  }
}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "랜덤 고양이",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              // 좋아요 페이지로 이동
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                },
              )
            ],
          ),
          // 고양이 사진 목록
          body: GridView.count(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            children: List.generate(
              catService.catImages.length,
              (index) {
                String catImageUrl = catService.catImages[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        catImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: IconButton(
                        onPressed: () {
                          catService.toggleFavoriteImage(catImageUrl);
                        },
                        icon: Icon(
                          catService.favoriteCatImages.contains(catImageUrl)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color:
                              catService.favoriteCatImages.contains(catImageUrl)
                                  ? Colors.pink
                                  : Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// 좋아요 페이지
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              "좋아요",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: GridView.count(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            children: List.generate(
              catService.favoriteCatImages.length,
              (index) {
                String catImageUrl = catService.favoriteCatImages[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        catImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: IconButton(
                        onPressed: () {
                          catService.toggleFavoriteImage(catImageUrl);
                        },
                        icon: Icon(
                          catService.favoriteCatImages.contains(catImageUrl)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color:
                              catService.favoriteCatImages.contains(catImageUrl)
                                  ? Colors.pink
                                  : Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
