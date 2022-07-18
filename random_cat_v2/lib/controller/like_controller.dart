import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:random_cat_v2/model/like_model.dart';

class LikeController extends GetxController {
  final likes = [].obs;
  final ids = [].obs;

  Box box = Hive.box("likecat");

  saveLike(id, url, isLike) async {
    Like like = Like(id, url, isLike);
    if (isLike) {
      await box.put(id, like);
    } else {
      await box.delete(id);
    }
    insertLikes();
  }

  getLike(id) async {
    Like like = await box.get(id);
    return like;
  }

  getAllLike() {
    final keys = box.toMap().keys;
    List<Like> tmp = [];
    for (final key in keys) {
      tmp.add(box.get(key));
    }
    return tmp;
  }

  checkLike(id) {
    for (final like in likes) {
      if (like.id == id) {
        return true;
      }
      return false;
    }
  }

  clearHive() async {
    await box.deleteFromDisk();
  }

  openHive() async {
    await Hive.openBox('likecat');
  }

  insertLikes() {
    likes.clear();
    ids.clear();
    List<Like> list = getAllLike();

    for (Like like in list) {
      likes.add(like);
      ids.add(like.id);
    }
  }

  @override
  void onInit() async {
    insertLikes();
    super.onInit();
  }
}
