import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Cat {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? url;

  @HiveField(2)
  bool isLike = false;

  Cat.no();
  Cat(this.id, this.url, this.isLike);

  @override
  String toString() {
    return '$id : $isLike';
  }
}
