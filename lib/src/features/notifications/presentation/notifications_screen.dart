import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ['Appointment confirmed', 'Prescription uploaded', 'Payment received'];
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.notifications_outlined)),
          title: Text(items[index]),
          subtitle: const Text('Just now'),
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: items.length,
      ),
    );
  }
}
