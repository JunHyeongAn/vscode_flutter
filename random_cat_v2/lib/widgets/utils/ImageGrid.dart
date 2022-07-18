// 이미지 그리드
// obx 같은 경우 이미지 하나하나에 걸면 안된다.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/widgets/utils/progress.dart';

import '../../controller/cat_controller.dart';
import '../../controller/like_controller.dart';

final catController = Get.find<CatController>();
final likeController = Get.find<LikeController>();

class ImageGridView extends StatelessWidget {
  final List items;
  const ImageGridView({
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed("/image", arguments: {
                        "id": items[index].id,
                        "index": index,
                      });
                    },
                    child: Image.network(
                      items[index].url,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress != null) {
                          return WaveProgress();
                        }
                        return child;
                      },
                    ),
                  ),
                ),
                LikeButton(
                  index: index,
                  id: items[index].id,
                  url: items[index].url,
                  isLike: items[index].isLike,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  final int index;
  final String id;
  final String url;
  final bool isLike;

  const LikeButton({
    Key? key,
    required this.index,
    required this.id,
    required this.url,
    required this.isLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        type: MaterialType.transparency,
        child: IconButton(
          splashRadius: 120,
          color: Colors.red.withOpacity(0.4),
          highlightColor: Colors.red.withOpacity(0.4),
          icon: Icon(
            isLike ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () => {
            catController.updateLike(index),
            likeController.saveLike(id, url, !isLike),
          },
        ),
      ),
    );
  }
}
