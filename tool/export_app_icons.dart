import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/caju_qr.dart';

/// Renders the settings-page QR marks into 1024 launcher masters.
///
/// Run: `flutter test tool/export_app_icons.dart`
void main() {
  testWidgets('export CajuQrView launcher icons', (tester) async {
    const logical = 72.0;
    const physical = 1024.0;
    tester.view.devicePixelRatio = physical / logical;
    tester.view.physicalSize = const Size(physical, physical);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    Future<void> export(AppIconStyle style, String filename) async {
      final key = GlobalKey();
      final bg = style == AppIconStyle.business
          ? CajuQrView.paper
          : const Color(0xFFFFF6E8);
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RepaintBoundary(
            key: key,
            child: ColoredBox(
              color: bg,
              child: CajuQrView(data: 'Caju', size: logical, style: style),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.runAsync(() async {
        final context = key.currentContext!;
        await precacheImage(
          const AssetImage('assets/brand/caju_logo_cutout.png'),
          context,
        );
        await precacheImage(
          const AssetImage('assets/brand/caju_logo_sketch.png'),
          context,
        );
      });
      await tester.pump();

      late final ui.Image image;
      late final ByteData? bytes;
      await tester.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        image = await boundary.toImage(pixelRatio: physical / logical);
        bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      });
      expect(bytes, isNotNull);
      final out = File('assets/icons/$filename');
      out.parent.createSync(recursive: true);
      out.writeAsBytesSync(bytes!.buffer.asUint8List());
      expect(out.lengthSync(), greaterThan(8000));
    }

    await export(AppIconStyle.anime, 'app_icon_anime_1024.png');
    await export(AppIconStyle.business, 'app_icon_business_1024.png');
  });
}
