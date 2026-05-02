import '../entities/locker.dart';
import '../repositories/locker_repository.dart';

class GetLockers {
  final LockerRepository repository;

  GetLockers(this.repository);

  Future<List<Locker>> call() {
    return repository.getLockers();
  }
}
