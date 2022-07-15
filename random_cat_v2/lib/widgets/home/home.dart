import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/controller/cat_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CatController>(
      () => CatController(),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ImageGrid(),
        ],
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: Get.find<CatController>().cats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              Get.find<CatController>().cats[index].url,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
