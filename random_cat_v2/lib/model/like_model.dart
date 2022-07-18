import 'package:hive/hive.dart';

part 'like_model.g.dart';

@HiveType(typeId: 2)
class Like {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? url;

  @HiveField(2)
  bool? isLike;

  @override
  String toString() {
    return '$id : $url';
  }

  Like(this.id, this.url, this.isLike);
}
