import '../../domain/entities/locker.dart';
import '../../domain/repositories/locker_repository.dart';
import '../datasources/locker_local_datasource.dart';
import '../models/locker_model.dart';

class LockerRepositoryImpl implements LockerRepository {
  final LockerLocalDatasource datasource;

  LockerRepositoryImpl(this.datasource);

  @override
  Future<void> createLocker(Locker locker) {
    final model = LockerModel.fromEntity(locker);
    return datasource.createLocker(model);
  }

  @override
  Future<List<Locker>> getLockers() async {
    final items = datasource.getLockers();
    return items.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Locker?> unlockLocker(String id) async {
    final model = datasource.getLockerById(id);
    if (model == null) {
      return null;
    }
    final updated = model.copyWith(unlockCount: model.unlockCount + 1);
    await datasource.updateLocker(updated);
    return updated.toEntity();
  }
}
