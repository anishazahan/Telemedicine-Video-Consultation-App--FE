import 'package:flutter/material.dart';

class PatientHistoryScreen extends StatelessWidget {
  const PatientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical history')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.monitor_heart_outlined), title: Text('Blood pressure'), subtitle: Text('Stable, last checked 2 weeks ago')),
          ListTile(leading: Icon(Icons.vaccines_outlined), title: Text('Allergies'), subtitle: Text('Penicillin')),
          ListTile(leading: Icon(Icons.medication_outlined), title: Text('Current medication'), subtitle: Text('Vitamin D, 1000 IU')),
        ],
      ),
    );
  }
}
