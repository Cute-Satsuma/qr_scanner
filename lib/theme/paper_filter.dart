import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/theme_controller.dart';

class PaperFilterOverlay extends StatelessWidget {
  const PaperFilterOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final extras = Theme.of(context).extension<CajuThemeExtras>();
    if (extras == null || !extras.paperFilter) return child;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final tint = Theme.of(context).colorScheme.primary;
    final grain = ThemeScope.of(context).paperGrain;
    return ValueListenableBuilder<double>(
      valueListenable: grain,
      builder: (context, amount, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _PaperGrainPainter(
                    dark: dark,
                    tint: tint,
                    grain: amount,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PaperGrainPainter extends CustomPainter {
  const _PaperGrainPainter({
    required this.dark,
    required this.tint,
    required this.grain,
  });

  final bool dark;
  final Color tint;
  final double grain;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final t = grain.clamp(0.0, 1.0);
    final wash = Color.lerp(
      dark ? const Color(0xFFC4A574) : const Color(0xFFD4B896),
      tint,
      0.22 + t * 0.12,
    )!;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = wash.withValues(alpha: (dark ? 0.08 : 0.06) + t * 0.12),
    );

    final random = math.Random(2026);
    final speckle = Paint()..style = PaintingStyle.fill;
    final count =
        (size.width * size.height / (160 - t * 100)).clamp(400, 3600).toInt();
    for (var i = 0; i < count; i++) {
      final ink = random.nextBool();
      speckle.color = (ink
              ? (dark ? const Color(0xFFE8D9C0) : const Color(0xFF5D4037))
              : (dark ? const Color(0xFF1A140E) : const Color(0xFFFFF8E8)))
          .withValues(alpha: (dark ? 0.04 : 0.03) + t * 0.22);
      canvas.drawCircle(
        Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        0.16 + random.nextDouble() * (0.38 + t * 0.56),
        speckle,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PaperGrainPainter oldDelegate) {
    return oldDelegate.dark != dark ||
        oldDelegate.tint != tint ||
        oldDelegate.grain != grain;
  }
}
