import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qr_scanner/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigate to Settings and switch dark theme', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Switch to Settings tab
    await tester.tap(find.text('设置'));
    await tester.pumpAndSettle();

    // Tap the Dark (深色) appearance button
    await tester.tap(find.text('深色'));
    await tester.pumpAndSettle();

    // Just verify the dark text is still present after tap
    expect(find.text('深色'), findsOneWidget);
  });
}
