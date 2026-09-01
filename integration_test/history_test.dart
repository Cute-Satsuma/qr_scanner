import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qr_scanner/history/history_page.dart';
import 'package:qr_scanner/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('generate QR and view history', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Generate a text QR code
    await tester.tap(find.text('生成'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('请输入要生成二维码的内容'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'history-test');
    await tester.pumpAndSettle();
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('history-test'), findsOneWidget);

    // Open history from Generate page using HistoryEntryButton
    await tester.tap(find.byType(HistoryEntryButton));
    await tester.pumpAndSettle();

    // History should show the generated record
    expect(find.textContaining('history-test'), findsOneWidget);
  });
}
