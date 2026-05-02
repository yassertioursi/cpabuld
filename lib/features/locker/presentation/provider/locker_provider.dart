import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/locker.dart';
import '../../domain/usecases/create_locker.dart';
import '../../domain/usecases/get_lockers.dart';
import '../../domain/usecases/unlock_locker.dart';

class LockerProvider extends ChangeNotifier {
  final CreateLocker createLocker;
  final GetLockers getLockers;
  final UnlockLocker unlockLocker;
  final Uuid _uuid = const Uuid();

  LockerProvider({
    required this.createLocker,
    required this.getLockers,
    required this.unlockLocker,
  });

  List<Locker> _lockers = [];
  bool _isLoading = false;
  String? _unlockingId;

  List<Locker> get lockers => List.unmodifiable(_lockers);
  bool get isLoading => _isLoading;
  String? get unlockingId => _unlockingId;

  Locker? lockerById(String id) {
    try {
      return _lockers.firstWhere((locker) => locker.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> loadLockers() async {
    _isLoading = true;
    notifyListeners();
    _lockers = await getLockers();
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> addLocker({
    required String title,
    required String link,
  }) async {
    final locker = Locker(
      id: _uuid.v4(),
      title: title.trim(),
      originalLink: link.trim(),
      unlockCount: 0,
    );
    await createLocker(locker);
    await loadLockers();
    return null;
  }

  Future<Locker?> unlock(String id) async {
    _unlockingId = id;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    final updated = await unlockLocker(id);
    await loadLockers();
    _unlockingId = null;
    notifyListeners();
    return updated;
  }
}
