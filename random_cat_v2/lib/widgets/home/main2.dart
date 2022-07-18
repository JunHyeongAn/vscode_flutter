import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/controller/like_controller.dart';

import '../utils/ImageGrid.dart';

final likeController = Get.find<LikeController>();

class LikePage extends StatelessWidget {
  const LikePage({Key? key}) : super(key: key);

  Future<void> _onRefresh() async {
    return await likeController.getAllLike();
  }

  @override
  Widget build(BuildContext context) {
    return ImageGridView(
      items: Get.find<LikeController>().likes,
    );
  }
}
