import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/controller/cat_controller.dart';

import 'main1.dart';

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
          ImageGridLayout(),
        ],
      ),
    );
  }
}
