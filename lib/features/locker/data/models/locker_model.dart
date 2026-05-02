import 'package:hive/hive.dart';

import '../../domain/entities/locker.dart';

class LockerModel extends HiveObject {
  final String id;

  final String title;

  final String originalLink;

  final int unlockCount;

  LockerModel({
    required this.id,
    required this.title,
    required this.originalLink,
    required this.unlockCount,
  });

  LockerModel copyWith({
    String? id,
    String? title,
    String? originalLink,
    int? unlockCount,
  }) {
    return LockerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      originalLink: originalLink ?? this.originalLink,
      unlockCount: unlockCount ?? this.unlockCount,
    );
  }

  Locker toEntity() {
    return Locker(
      id: id,
      title: title,
      originalLink: originalLink,
      unlockCount: unlockCount,
    );
  }

  factory LockerModel.fromEntity(Locker locker) {
    return LockerModel(
      id: locker.id,
      title: locker.title,
      originalLink: locker.originalLink,
      unlockCount: locker.unlockCount,
    );
  }
}

class LockerModelAdapter extends TypeAdapter<LockerModel> {
  @override
  final int typeId = 1;

  @override
  LockerModel read(BinaryReader reader) {
    final fieldCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldCount; i++) {
      final key = reader.readByte();
      fields[key] = reader.read();
    }
    return LockerModel(
      id: fields[0] as String,
      title: fields[1] as String,
      originalLink: fields[2] as String,
      unlockCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LockerModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.originalLink)
      ..writeByte(3)
      ..write(obj.unlockCount);
  }
}
