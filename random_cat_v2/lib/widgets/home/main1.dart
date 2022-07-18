// 전체적인 로딩관여
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/controller/cat_controller.dart';
import 'package:random_cat_v2/widgets/utils/progress.dart';

import '../utils/ImageGrid.dart';

final catController = Get.find<CatController>();

class ImageGridLayout extends StatelessWidget {
  const ImageGridLayout({
    Key? key,
  }) : super(key: key);

  Future<void> _onRefresh() async {
    return await catController.refreshCat();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: FutureBuilder(
        future: catController.getCats(),
        builder: (context, snapshot) {
          var content = (snapshot.connectionState == ConnectionState.done)
              ? ImageGridView(items: Get.find<CatController>().cats)
              : WaveProgress();
          return content;
        },
      ),
    );
  }
}
