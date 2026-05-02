import 'package:hive/hive.dart';

import '../models/locker_model.dart';

class LockerLocalDatasource {
  static const String boxName = 'lockers';

  Box<LockerModel> get _box => Hive.box<LockerModel>(boxName);

  Future<void> createLocker(LockerModel model) async {
    await _box.put(model.id, model);
  }

  List<LockerModel> getLockers() {
    return _box.values.toList();
  }

  LockerModel? getLockerById(String id) {
    return _box.get(id);
  }

  Future<void> updateLocker(LockerModel model) async {
    await _box.put(model.id, model);
  }
}
