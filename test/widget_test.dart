import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/app/telemed_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('MediConnect app boots', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TelemedApp()));
    await tester.pump();
    expect(find.text('MediConnect'), findsOneWidget);
  });
}
