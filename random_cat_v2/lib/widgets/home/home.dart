import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_cat_v2/controller/cat_controller.dart';
import 'package:random_cat_v2/controller/like_controller.dart';
import 'package:random_cat_v2/widgets/home/main2.dart';
import 'package:random_cat_v2/widgets/home/main3.dart';

import 'main1.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CatController>(
      () => CatController(),
    );
    Get.lazyPut<LikeController>(
      () => LikeController(),
    );

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          ImageGridLayout(),
          LikePage(),
          Main3(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.heart_fill,
            ),
            label: "like",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_fill,
            ),
            label: "myPage",
          ),
        ],
      ),
    );
  }
}
