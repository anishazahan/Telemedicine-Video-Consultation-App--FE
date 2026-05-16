import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/glass_card.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Consultation fee', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text('\$85.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: 'Card number', prefixIcon: Icon(Icons.credit_card))),
                const SizedBox(height: 12),
                const Row(children: [
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'MM/YY'))),
                  SizedBox(width: 12),
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'CVC'))),
                ]),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: () => context.go('/'), child: const Text('Pay and confirm')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
