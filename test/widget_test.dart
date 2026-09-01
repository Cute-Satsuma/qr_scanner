import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/theme/theme_controller.dart';

void main() {
  testWidgets('app shows scan navigation', (WidgetTester tester) async {
    await tester.pumpWidget(
      QrScannerApp(themeController: ThemeController()),
    );
    await tester.pump();
    expect(find.text('Scan'), findsWidgets);
  });
}
