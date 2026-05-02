import '../entities/locker.dart';
import '../repositories/locker_repository.dart';

class CreateLocker {
  final LockerRepository repository;

  CreateLocker(this.repository);

  Future<void> call(Locker locker) {
    return repository.createLocker(locker);
  }
}
