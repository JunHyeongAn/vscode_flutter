// 전체적인 로딩관여
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/controller/cat_controller.dart';
import 'package:random_cat_v2/widgets/utils/progress.dart';

class ImageGridLayout extends StatelessWidget {
  const ImageGridLayout({
    Key? key,
  }) : super(key: key);

  Future<void> _onRefresh() async {
    return await Get.find<CatController>().getCats();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: FutureBuilder(
        future: Get.find<CatController>().getCats(),
        builder: (context, snapshot) {
          var content = (snapshot.connectionState == ConnectionState.done)
              ? ImageGridView()
              : WaveProgress();
          return content;
        },
      ),
    );
  }
}

// 이미지 그리드
// obx 같은 경우 이미지 하나하나에 걸면 안된다.
class ImageGridView extends StatelessWidget {
  const ImageGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        itemCount: Get.find<CatController>().cats.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              Get.find<CatController>().cats[index].url,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress != null) {
                  return WaveProgress();
                }
                return child;
              },
            ),
          );
        },
      ),
    );
  }
}
