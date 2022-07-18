import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:random_cat_v2/controller/like_controller.dart';
import 'package:random_cat_v2/model/cat_model.dart';

class CatController extends GetxController {
  final cats = [].obs;
  RxString id = "".obs;
  RxString url = "".obs;
  RxBool isLike = false.obs;

  Box box = Hive.box("likecat");

  var dio = Dio();

  getCats() async {
    if (cats.isNotEmpty) {
      return false;
    }
    cats.clear();
    String url = "https://api.thecatapi.com/v1/images/search?limit=20";
    final response = await dio.get(url);
    for (var i = 0; i < response.data.length; i++) {
      final data = response.data;
      bool isLike = Get.find<LikeController>().ids.contains(data[i]["id"]);
      Cat cat = Cat(data[i]["id"], data[i]["url"], isLike);
      cats.add(cat);
    }
  }

  refreshCat() async {
    cats.clear();
    String url = "https://api.thecatapi.com/v1/images/search?limit=20";
    final response = await dio.get(url);
    for (var i = 0; i < response.data.length; i++) {
      final data = response.data;
      bool isLike = Get.find<LikeController>().ids.contains(data[i]["id"]);
      Cat cat = Cat(data[i]["id"], data[i]["url"], isLike);
      cats.add(cat);
    }
  }

  getCat(catId) async {
    String fetchUrl = "https://api.thecatapi.com/v1/images/$catId";
    final response = await dio.get(fetchUrl);
    final data = response.data;
    bool isInLike = Get.find<LikeController>().ids.contains(data["id"]);
    id(data["id"]);
    url(data["url"]);
    isLike(isInLike);
    return isLike;
  }

  // 단일 좋아요
  catLike() {
    isLike(!isLike.value);
    Get.find<LikeController>().saveLike(id.value, url.value, isLike.value);
    cats.add(Cat("idLike", "url", false));
    cats.removeAt(cats.length - 1);
  }

  // 리스트 index에 해당하는 인스턴스 like업데이트 및 리스트 갯수를 바꿔줌으로서 강제로 랜더링
  updateLike(index) {
    cats[index].isLike = !cats[index].isLike;
    cats.add(Cat("idLike", "url", false));
    cats.removeAt(cats.length - 1);
  }
}
