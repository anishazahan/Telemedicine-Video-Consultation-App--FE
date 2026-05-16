import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../data/auth_repository.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(data: (user) => context.go(user == null ? '/login' : '/'));
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 36, backgroundColor: AppColors.primary, child: Icon(Icons.health_and_safety, color: Colors.white, size: 38)),
            SizedBox(height: 18),
            Text('MediConnect', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            SizedBox(height: 8),
            Text('Premium care, anywhere'),
          ],
        ),
      ),
    );
  }
}
