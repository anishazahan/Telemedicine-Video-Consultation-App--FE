import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../appointments/data/appointment_repository.dart';
import '../../auth/data/auth_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final appointments = ref.watch(appointmentsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text('Hi, ${user?.name.split(' ').first ?? 'Patient'}'),
              actions: [
                IconButton(onPressed: () => context.push('/notifications'), icon: const Icon(Icons.notifications_outlined)),
                IconButton(onPressed: () => context.push('/settings'), icon: const Icon(Icons.settings_outlined)),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(
                children: [
                  GlassCard(
                    child: Row(
                      children: [
                        const CircleAvatar(radius: 30, backgroundColor: AppColors.mint, child: Icon(Icons.video_call, color: AppColors.primary)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.t(context, 'welcome'), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              const Text('Find verified doctors and manage your care plan.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 4 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.28,
                    children: [
                      _ActionTile(icon: Icons.medical_services_outlined, label: 'Doctors', onTap: () => context.push('/doctors')),
                      _ActionTile(icon: Icons.history, label: 'History', onTap: () => context.push('/history')),
                      _ActionTile(icon: Icons.receipt_long_outlined, label: 'Prescriptions', onTap: () => context.push('/prescriptions')),
                      _ActionTile(icon: Icons.person_outline, label: 'Profile', onTap: () => context.push('/profile')),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text('Upcoming appointment', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  appointments.when(
                    data: (items) => GlassCard(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(child: Icon(Icons.calendar_month)),
                        title: Text(items.isEmpty ? 'No appointment booked' : items.first.doctorName),
                        subtitle: Text(items.isEmpty ? 'Explore doctors to book your first visit' : items.first.status),
                        trailing: IconButton(
                          icon: const Icon(Icons.videocam_outlined),
                          onPressed: items.isEmpty ? null : () => context.push('/call/${items.first.meetingRoomId}'),
                        ),
                      ),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (error, _) => Text(error.toString()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        onDestinationSelected: (index) {
          if (index == 1) context.push('/chat/demo');
          if (index == 2) context.push('/profile');
        },
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          Text(label, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
