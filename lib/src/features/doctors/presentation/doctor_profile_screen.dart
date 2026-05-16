import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../data/doctor_repository.dart';

class DoctorProfileScreen extends ConsumerWidget {
  const DoctorProfileScreen({super.key, required this.doctorId});
  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = ref.watch(doctorProvider(doctorId));
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor profile')),
      body: doctor.when(
        data: (item) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GlassCard(
              child: Column(
                children: [
                  CircleAvatar(radius: 44, backgroundColor: AppColors.mint, child: Text(item.name.substring(0, 1), style: const TextStyle(fontSize: 32))),
                  const SizedBox(height: 12),
                  Text(item.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                  Text(item.specialization),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Metric(label: 'Rating', value: item.ratingAverage.toStringAsFixed(1)),
                      _Metric(label: 'Experience', value: '${item.experienceYears}y'),
                      _Metric(label: 'Fee', value: '\$${item.consultationFee.toStringAsFixed(0)}'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text('About', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(item.bio ?? 'Verified healthcare professional available for secure online consultations.'),
            const SizedBox(height: 24),
            ElevatedButton.icon(onPressed: () => context.push('/appointments/book/${item.id}'), icon: const Icon(Icons.calendar_month), label: const Text('Book appointment')),
            const SizedBox(height: 10),
            OutlinedButton.icon(onPressed: () => context.push('/chat/demo'), icon: const Icon(Icons.chat_outlined), label: const Text('Message clinic')),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)), Text(label)]);
  }
}
