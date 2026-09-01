import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qr_scanner/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('generate text QR code on iOS', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Switch to Generate tab
    await tester.tap(find.text('生成'));
    await tester.pumpAndSettle();

    // Tap the center area to open input sheet
    await tester.tap(find.text('请输入要生成二维码的内容'));
    await tester.pumpAndSettle();

    // Enter text into the first TextField in the input sheet
    await tester.enterText(find.byType(TextField).first, 'hello-ios');
    await tester.pumpAndSettle();

    // Tap confirm button
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify content preview appears
    expect(find.text('hello-ios'), findsOneWidget);
  });

  testWidgets('switch to link type and generate url QR code on iOS', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.text('生成'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('链接'));
    await tester.pumpAndSettle();

    // The sheet should show the link input field with previous/default content
    await tester.tap(find.byType(TextField).first);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'https://example.com');
    await tester.pumpAndSettle();

    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Check that generated content contains example.com (avoid full URL parsing issues)
    expect(find.textContaining('example.com'), findsOneWidget);
  });
}
