import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:getx_practice/controller/count_controller_obs.dart';

import 'controller/count_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(title: "GetX"),
      home: MyHomePageObs(
        title: "GetXObs",
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //GetX로 상태 관리를 하기 위해서는 GetX로 만든 컨트롤러를 다음과 같이 Get.put을 사용하여 등록(Register)할 필요가 있습니다.
    final controller = Get.put(CountController());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

            ///////////////////////////////////////////////////
            ///GetBuilder를 사용하지 않으면, 상태가 변경된 것을 인지하지 못하고, 변경된 값을 화면에 반영할 수 없습니다.
            GetBuilder<CountController>(builder: (controller) {
              return Text(
                '${controller.count}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            ///////////////////////////////////////////////////
            ///
            ///
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyHomePageObs extends StatelessWidget {
  final String title;

  const MyHomePageObs({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CountControllerObs());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

            ////////////////////////////////////////////////
            Obx(
              () => Text(
                "${controller.count.value}",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ////////////////////////////////////////////////
            ///
            ///
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyHomePageFind extends StatelessWidget {
  final String title;

  const MyHomePageFind({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerObs());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              () => Text(
                // Get.find을 사용하면 Get.put으로 등록한 컨트롤러를 어디에서든 접근하여 사용할 수 있습니다.
                "${Get.find<CountControllerObs>().count.value}",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Get.find<CountControllerObs>().increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
