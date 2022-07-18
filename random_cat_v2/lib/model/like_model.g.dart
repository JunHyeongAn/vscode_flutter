// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikeAdapter extends TypeAdapter<Like> {
  @override
  final int typeId = 2;

  @override
  Like read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Like(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Like obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.isLike);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
