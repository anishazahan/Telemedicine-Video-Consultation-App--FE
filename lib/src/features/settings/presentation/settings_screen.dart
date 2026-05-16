import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/telemed_app.dart';
import '../../auth/data/auth_repository.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: theme == ThemeMode.dark,
            title: const Text('Dark mode'),
            onChanged: (value) => ref.read(themeModeProvider.notifier).setMode(value ? ThemeMode.dark : ThemeMode.light),
          ),
          DropdownButtonFormField<Locale>(
            initialValue: locale,
            decoration: const InputDecoration(labelText: 'Language'),
            items: const [
              DropdownMenuItem(value: Locale('en'), child: Text('English')),
              DropdownMenuItem(value: Locale('bn'), child: Text('বাংলা')),
              DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
            ],
            onChanged: (value) {
              if (value != null) ref.read(localeProvider.notifier).setLocale(value);
            },
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
