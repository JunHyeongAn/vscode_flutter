import 'package:get/get.dart';

class CountControllerObs extends GetxController {
  //단순 상태 관리와 다르게 상태 변수를 생성할 때 .obs를 사용하여 생성합니다.
  //이렇게 생성한 변수는 단순한 타입이 아닌 RxInt와 같이 반응형 상태 변수가 됩니다.
  final count = 0.obs;

  void increment() {
    count.value++;
    // or
    // count(count.value + 1);
    ever(count, (_) => print("called every update"));
    once(count, (_) => print("called once"));
    debounce(count, (_) => print("called after 1 second after last change"),
        time: Duration(seconds: 1));
    interval(
        count, (_) => print("called every second during the value is changed."),
        time: Duration(seconds: 1));
  }
}
