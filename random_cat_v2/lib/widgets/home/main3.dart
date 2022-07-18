import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/normal_card.dart';

class Main3 extends StatelessWidget {
  const Main3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "my page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          NormalCard(
            title: "login",
            ontap: () {
              Get.toNamed("/login");
            },
          ),
        ],
      ),
    );
  }
}
