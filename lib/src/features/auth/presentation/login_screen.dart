import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../data/auth_repository.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController(text: 'patient@example.com');
    final password = useTextEditingController(text: 'password123');
    final auth = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(data: (user) {
        if (user != null) context.go('/');
      });
    });

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 40),
            Text(AppStrings.t(context, 'welcome'), style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Text('Book doctors, chat securely, and join video consultations from one polished mobile experience.', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 28),
            GlassCard(
              child: Column(
                children: [
                  TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 12),
                  TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: auth.isLoading ? null : () => ref.read(authControllerProvider.notifier).login(email.text, password.text),
                    child: auth.isLoading ? const CircularProgressIndicator.adaptive() : const Text('Login'),
                  ),
                  TextButton(onPressed: () => context.push('/register'), child: const Text('Create an account')),
                  if (auth.hasError) Text(auth.error.toString(), style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
