import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/glass_card.dart';
import '../data/appointment_repository.dart';

class AppointmentBookingScreen extends HookConsumerWidget {
  const AppointmentBookingScreen({super.key, required this.doctorId});
  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reason = useTextEditingController();
    final selected = useState(DateTime.now().add(const Duration(days: 1, hours: 2)));
    final loading = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Book appointment')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select consultation time', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(6, (i) {
                    final time = DateTime.now().add(Duration(days: 1, hours: 9 + i));
                    return ChoiceChip(
                      selected: selected.value.hour == time.hour,
                      label: Text('${time.hour}:00'),
                      onSelected: (_) => selected.value = time,
                    );
                  }),
                ),
                const SizedBox(height: 16),
                TextField(controller: reason, minLines: 3, maxLines: 4, decoration: const InputDecoration(labelText: 'Reason for visit')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loading.value
                      ? null
                      : () async {
                          loading.value = true;
                          try {
                            await ref.read(appointmentRepositoryProvider).book(
                                  doctorId: doctorId,
                                  startsAt: selected.value,
                                  endsAt: selected.value.add(const Duration(minutes: 30)),
                                  reason: reason.text.isEmpty ? 'General consultation' : reason.text,
                                );
                            if (context.mounted) context.push('/payment');
                          } catch (error) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking failed: $error')));
                            }
                          } finally {
                            loading.value = false;
                          }
                        },
                  child: Text(loading.value ? 'Booking...' : 'Continue to payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
