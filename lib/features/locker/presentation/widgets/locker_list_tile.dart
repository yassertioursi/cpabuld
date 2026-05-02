import 'package:flutter/material.dart';

import '../../domain/entities/locker.dart';

class LockerListTile extends StatelessWidget {
  final Locker locker;
  final VoidCallback onTap;

  const LockerListTile({
    super.key,
    required this.locker,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(locker.title),
        subtitle: Text('Unlocks: ${locker.unlockCount}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
