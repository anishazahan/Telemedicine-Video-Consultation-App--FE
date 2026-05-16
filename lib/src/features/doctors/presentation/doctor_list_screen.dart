import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../data/doctor.dart';
import '../data/doctor_repository.dart';

class DoctorListScreen extends HookConsumerWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useTextEditingController();
    final query = useState(const DoctorQuery());
    final doctors = ref.watch(doctorsProvider(query.value));

    return Scaffold(
      appBar: AppBar(title: const Text('Find doctors')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(doctorsProvider(query.value).future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: search,
              decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: AppStrings.t(context, 'searchDoctors')),
              onSubmitted: (value) => query.value = DoctorQuery(search: value),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ['Cardiology', 'Dermatology', 'Pediatrics', 'Neurology']
                  .map((item) => FilterChip(label: Text(item), onSelected: (_) => query.value = DoctorQuery(search: search.text, specialization: item)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            doctors.when(
              data: (items) => Column(children: items.map((doctor) => _DoctorCard(doctor: doctor)).toList()),
              loading: () => const Column(children: [Skeleton(height: 96), SizedBox(height: 12), Skeleton(height: 96), SizedBox(height: 12), Skeleton(height: 96)]),
              error: (error, _) => Text(error.toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  const _DoctorCard({required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        onTap: () => context.push('/doctors/${doctor.id}'),
        child: Row(
          children: [
            CircleAvatar(radius: 30, child: Text(doctor.name.substring(0, 1))),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  Text('${doctor.specialization} • ${doctor.experienceYears} yrs'),
                  const SizedBox(height: 6),
                  Row(children: [const Icon(Icons.star, size: 16, color: Colors.amber), Text(' ${doctor.ratingAverage}'), const Spacer(), Text('\$${doctor.consultationFee.toStringAsFixed(0)}')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
