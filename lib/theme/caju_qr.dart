import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/theme_controller.dart';

class CajuLogoBadge extends StatelessWidget {
  const CajuLogoBadge({
    super.key,
    this.size,
    this.background = const Color(0xFFFFF6E8),
  });

  final double? size;
  final Color background;

  @override
  Widget build(BuildContext context) {
    const image = Image(
      image: AssetImage('assets/brand/caju_logo_cutout.png'),
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
    if (size == null) return image;
    return SizedBox.square(dimension: size, child: image);
  }
}

class CajuSketch extends StatelessWidget {
  const CajuSketch({
    super.key,
    this.size = 32,
    this.color = const Color(0xFF4E342E),
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: const Image(
        image: AssetImage('assets/brand/caju_logo_sketch.png'),
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class CajuQrView extends StatelessWidget {
  const CajuQrView({
    super.key,
    required this.data,
    this.size,
    this.style,
  });

  final String data;
  final double? size;
  final AppIconStyle? style;

  static const _cream = Color(0xFFFFF6E8);
  static const _animeInk = Color(0xFFBF360C);
  static const paper = Color(0xFFF3EBDA);
  static const graphite = Color(0xFF3C3A36);
  static const _padding = 12.0;

  @override
  Widget build(BuildContext context) {
    final resolved = style ?? ThemeScope.of(context).iconStyle;
    final sketch = resolved == AppIconStyle.business;
    final bg = sketch ? paper : _cream;
    final ink = sketch ? graphite : _animeInk;
    final radius = sketch ? 0.0 : 18.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final side = size ?? constraints.biggest.shortestSide;
        final qr = _encode(data);
        if (qr == null) {
          return const SizedBox.shrink();
        }
        final n = qr.moduleCount;
        final content = (side - _padding * 2).clamp(1.0, side);
        final cell = content / n;
        final keepOut = cell * 3.0;
        final moduleR = cell * 0.4;
        final island = ((keepOut - moduleR) * 2).clamp(18.0, side * 0.28);
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: ColoredBox(
            color: bg,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size.square(side),
                  painter: _CajuQrPainter(
                    qr: qr,
                    ink: ink,
                    keepOut: keepOut,
                    padding: _padding,
                  ),
                ),
                SizedBox.square(
                  dimension: island,
                  child: sketch
                      ? CajuSketch(size: island)
                      : CajuLogoBadge(size: island, background: bg),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static QrImage? _encode(String data) {
    try {
      return QrImage(
        QrCode.fromData(
          data: data,
          errorCorrectLevel: QrErrorCorrectLevel.H,
        ),
      );
    } on Exception {
      return null;
    }
  }
}

class _CajuQrPainter extends CustomPainter {
  const _CajuQrPainter({
    required this.qr,
    required this.ink,
    required this.keepOut,
    required this.padding,
  });

  final QrImage qr;
  final Color ink;
  final double keepOut;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    final n = qr.moduleCount;
    final s = size.shortestSide;
    final origin = Offset(
      (size.width - s) / 2 + padding,
      (size.height - s) / 2 + padding,
    );
    final content = s - padding * 2;
    if (content <= 0) return;
    final cell = content / n;
    final qrCenter = origin + Offset(content / 2, content / 2);
    final moduleR = cell * 0.4;
    final fill = Paint()
      ..color = ink
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final ring = Paint()
      ..color = ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = cell * 0.92
      ..isAntiAlias = true;

    bool finder(int x, int y) {
      const f = 7;
      return (x < f && y < f) ||
          (x >= n - f && y < f) ||
          (x < f && y >= n - f);
    }

    for (var y = 0; y < n; y++) {
      for (var x = 0; x < n; x++) {
        if (finder(x, y) || !qr.isDark(y, x)) continue;
        final center = origin + Offset((x + 0.5) * cell, (y + 0.5) * cell);
        if ((center - qrCenter).distance < keepOut + moduleR) continue;
        canvas.drawCircle(center, moduleR, fill);
      }
    }

    void eye(int mx, int my) {
      final rect = Rect.fromLTWH(
        origin.dx + mx * cell,
        origin.dy + my * cell,
        7 * cell,
        7 * cell,
      );
      canvas.drawCircle(rect.center, 3.15 * cell, ring);
      canvas.drawCircle(rect.center, 1.35 * cell, fill);
    }

    eye(0, 0);
    eye(n - 7, 0);
    eye(0, n - 7);
  }

  @override
  bool shouldRepaint(covariant _CajuQrPainter oldDelegate) {
    return oldDelegate.qr != qr ||
        oldDelegate.ink != ink ||
        oldDelegate.keepOut != keepOut ||
        oldDelegate.padding != padding;
  }
}
