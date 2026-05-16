import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/glass_card.dart';
import '../data/auth_repository.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    final auth = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(data: (user) {
        if (user != null) context.go('/');
      });
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          GlassCard(
            child: Column(
              children: [
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Full name')),
                const SizedBox(height: 12),
                TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 12),
                TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: auth.isLoading ? null : () => ref.read(authControllerProvider.notifier).register(name.text, email.text, password.text),
                  child: const Text('Register as patient'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
