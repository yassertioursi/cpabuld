import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/locker.dart';
import '../provider/locker_provider.dart';
import '../widgets/locker_list_tile.dart';
import 'create_locker_page.dart';
import 'locker_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openCreate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CreateLockerPage()),
    );
  }

  void _openDetail(BuildContext context, Locker locker) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LockerDetailPage(lockerId: locker.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CPAbuild')),
      body: Consumer<LockerProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.lockers.isEmpty) {
            return const Center(child: Text('No lockers yet.'));
          }
          return ListView.builder(
            itemCount: provider.lockers.length,
            itemBuilder: (context, index) {
              final locker = provider.lockers[index];
              return LockerListTile(
                locker: locker,
                onTap: () => _openDetail(context, locker),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreate(context),
        icon: const Icon(Icons.add),
        label: const Text('Create Locker'),
      ),
    );
  }
}
