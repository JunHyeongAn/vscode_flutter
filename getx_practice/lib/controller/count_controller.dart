import 'package:get/get_state_manager/get_state_manager.dart';

class CountController extends GetxController {
  int count = 0;

  void increment() {
    count++;
    update();
  }
}
