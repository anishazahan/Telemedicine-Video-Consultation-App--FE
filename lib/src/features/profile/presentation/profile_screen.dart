import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/data/auth_repository.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(radius: 42, child: Text((user?.name ?? 'P').substring(0, 1))),
          const SizedBox(height: 16),
          TextField(controller: TextEditingController(text: user?.name ?? ''), decoration: const InputDecoration(labelText: 'Name')),
          const SizedBox(height: 12),
          TextField(controller: TextEditingController(text: user?.email ?? ''), decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text('Save profile')),
        ],
      ),
    );
  }
}
