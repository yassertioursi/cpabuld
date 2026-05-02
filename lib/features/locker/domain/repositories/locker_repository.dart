import '../entities/locker.dart';

abstract class LockerRepository {
  Future<void> createLocker(Locker locker);
  Future<List<Locker>> getLockers();
  Future<Locker?> unlockLocker(String id);
}
