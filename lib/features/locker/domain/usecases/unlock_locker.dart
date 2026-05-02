import '../entities/locker.dart';
import '../repositories/locker_repository.dart';

class UnlockLocker {
  final LockerRepository repository;

  UnlockLocker(this.repository);

  Future<Locker?> call(String id) {
    return repository.unlockLocker(id);
  }
}
