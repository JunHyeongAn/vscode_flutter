import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/model/cat_model.dart';

class CatController extends GetxController {
  final cats = [].obs;
  String url = "https://api.thecatapi.com/v1/images/search?limit=20";
  var dio = Dio();

  getCats() async {
    cats.clear();
    final response = await dio.get(url);
    for (var i = 0; i < response.data.length; i++) {
      final data = response.data;
      Cat cat = Cat(data[i]["id"], data[i]["url"]);
      cats.add(cat);
    }
  }
}
