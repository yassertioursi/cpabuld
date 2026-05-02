import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/locker_provider.dart';

class LockerDetailPage extends StatefulWidget {
  final String lockerId;

  const LockerDetailPage({
    super.key,
    required this.lockerId,
  });

  @override
  State<LockerDetailPage> createState() => _LockerDetailPageState();
}

class _LockerDetailPageState extends State<LockerDetailPage> {
  bool _showLink = false;

  Future<void> _unlock(BuildContext context) async {
    final provider = context.read<LockerProvider>();
    final locker = await provider.unlock(widget.lockerId);
    if (!mounted) return;
    if (locker != null) {
      setState(() => _showLink = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LockerProvider>(
      builder: (context, provider, _) {
        final locker = provider.lockerById(widget.lockerId);
        if (locker == null) {
          return const Scaffold(
            body: Center(child: Text('Locker not found.')),
          );
        }
        final isUnlocking = provider.unlockingId == locker.id;
        final showLink = _showLink || locker.unlockCount > 0;
        return Scaffold(
          appBar: AppBar(title: Text(locker.title)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Locked Content',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  showLink ? locker.originalLink : '*** *** ***',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isUnlocking ? null : () => _unlock(context),
                    child: isUnlocking
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Unlock'),
                  ),
                ),
                const SizedBox(height: 12),
                Text('Unlock count: ${locker.unlockCount}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
