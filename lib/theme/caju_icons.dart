import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/theme_controller.dart';

enum CajuIconKind {
  info,
  palette,
  torchOn,
  torchOff,
  gallery,
  cameraSwitch,
  scan,
  generate,
  cajuQr,
  caju,
  history,
  settings,
  back,
  share,
  typeText,
  typeUrl,
  typeWifi,
  typePhone,
  typeEmail,
  wifiLock,
  wifiShield,
  wifiOpen,
  delete,
  copy,
  search,
  typeSms,
  typeGeo,
  typeProduct,
  typeContact,
  typeIsbn,
}

CajuIconKind cajuIconForContent(String? type) {
  switch (type?.toLowerCase()) {
    case 'url':
      return CajuIconKind.typeUrl;
    case 'wifi':
      return CajuIconKind.typeWifi;
    case 'phone':
      return CajuIconKind.typePhone;
    case 'email':
      return CajuIconKind.typeEmail;
    case 'sms':
      return CajuIconKind.typeSms;
    case 'geo':
      return CajuIconKind.typeGeo;
    case 'product':
      return CajuIconKind.typeProduct;
    case 'contact':
      return CajuIconKind.typeContact;
    case 'isbn':
      return CajuIconKind.typeIsbn;
    default:
      return CajuIconKind.typeText;
  }
}

class CajuAnimeIcon extends StatelessWidget {
  const CajuAnimeIcon({
    super.key,
    required this.kind,
    this.size = 28,
    this.dimmed = false,
    this.style,
    this.color,
  });

  final CajuIconKind kind;
  final double size;
  final bool dimmed;
  final AppIconStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolved = style ??
        context.dependOnInheritedWidgetOfExactType<ThemeScope>()?.notifier?.iconStyle ??
        AppIconStyle.anime;
    final ink = color ??
        (resolved == AppIconStyle.business
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.primary);
    return Opacity(
      opacity: dimmed ? 0.72 : 1,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          size: Size.square(size),
          painter: resolved == AppIconStyle.business
              ? _BusinessIconPainter(kind: kind, color: ink)
              : _AnimeIconPainter(kind: kind),
        ),
      ),
    );
  }
}

class _AnimeIconPainter extends CustomPainter {
  const _AnimeIconPainter({required this.kind});

  final CajuIconKind kind;

  static const _line = Color(0xFF4E342E);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    canvas.save();
    canvas.translate((size.width - s) / 2, (size.height - s) / 2);
    canvas.scale(s / 32);
    switch (kind) {
      case CajuIconKind.info:
        _info(canvas);
      case CajuIconKind.palette:
        _palette(canvas);
      case CajuIconKind.torchOn:
        _star(canvas, lit: true);
      case CajuIconKind.torchOff:
        _star(canvas, lit: false);
      case CajuIconKind.gallery:
        _gallery(canvas);
      case CajuIconKind.cameraSwitch:
        _camera(canvas);
      case CajuIconKind.scan:
        _scan(canvas);
      case CajuIconKind.generate:
        _generate(canvas);
      case CajuIconKind.cajuQr:
        _cajuQr(canvas);
      case CajuIconKind.caju:
        _caju(canvas);
      case CajuIconKind.history:
        _history(canvas);
      case CajuIconKind.settings:
        _settings(canvas);
      case CajuIconKind.back:
        _back(canvas);
      case CajuIconKind.share:
        _share(canvas);
      case CajuIconKind.typeText:
        _typeText(canvas);
      case CajuIconKind.typeUrl:
        _typeUrl(canvas);
      case CajuIconKind.typeWifi:
        _typeWifi(canvas);
      case CajuIconKind.typePhone:
        _typePhone(canvas);
      case CajuIconKind.typeEmail:
        _typeEmail(canvas);
      case CajuIconKind.wifiLock:
        _wifiLock(canvas, open: false);
      case CajuIconKind.wifiShield:
        _wifiShield(canvas);
      case CajuIconKind.wifiOpen:
        _wifiLock(canvas, open: true);
      case CajuIconKind.delete:
        _delete(canvas);
      case CajuIconKind.copy:
        _copy(canvas);
      case CajuIconKind.search:
        _search(canvas);
      case CajuIconKind.typeSms:
        _typeSms(canvas);
      case CajuIconKind.typeGeo:
        _typeGeo(canvas);
      case CajuIconKind.typeProduct:
        _typeProduct(canvas);
      case CajuIconKind.typeContact:
        _typeContact(canvas);
      case CajuIconKind.typeIsbn:
        _typeIsbn(canvas);
    }
    canvas.restore();
  }

  Paint get _stroke => Paint()
    ..color = _line
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.7
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true;

  Paint _fill(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  void _blob(Canvas canvas, Rect rect, Color color, {double radius = 8}) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, _fill(color));
    canvas.drawRRect(rrect, _stroke);
    canvas.drawOval(
      Rect.fromLTWH(rect.left + 2.2, rect.top + 1.6, rect.width * 0.42, 3.2),
      _fill(Colors.white.withValues(alpha: 0.45)),
    );
  }

  void _spark(Canvas canvas, Offset c, {double r = 2.4, Color color = const Color(0xFFFFF176)}) {
    final path = Path();
    for (var i = 0; i < 4; i++) {
      final a = -math.pi / 2 + i * math.pi / 2;
      final outer = Offset(c.dx + math.cos(a) * r, c.dy + math.sin(a) * r);
      final mid = Offset(
        c.dx + math.cos(a + math.pi / 4) * r * 0.32,
        c.dy + math.sin(a + math.pi / 4) * r * 0.32,
      );
      if (i == 0) {
        path.moveTo(outer.dx, outer.dy);
      } else {
        path.lineTo(outer.dx, outer.dy);
      }
      path.lineTo(mid.dx, mid.dy);
    }
    path.close();
    canvas.drawPath(path, _fill(color));
    canvas.drawPath(path, _stroke..strokeWidth = 1.2);
  }

  void _info(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(3, 3, 26, 26), const Color(0xFF80DEEA), radius: 13);
    canvas.drawCircle(const Offset(16, 11), 1.6, _fill(const Color(0xFF4E342E)));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(14.6, 14.6, 2.8, 9),
        const Radius.circular(1.4),
      ),
      _fill(const Color(0xFF4E342E)),
    );
    _spark(canvas, const Offset(25.5, 6.5), r: 2.2);
  }

  void _palette(Canvas canvas) {
    final body = Path()
      ..addOval(const Rect.fromLTWH(3, 4, 24, 23))
      ..addOval(const Rect.fromLTWH(20, 18, 9, 9));
    body.fillType = PathFillType.evenOdd;
    canvas.drawPath(body, _fill(const Color(0xFFFFE082)));
    canvas.drawPath(body, _stroke);
    canvas.drawCircle(const Offset(11, 11), 2.5, _fill(const Color(0xFFFF6B9D)));
    canvas.drawCircle(const Offset(18.5, 10), 2.3, _fill(const Color(0xFF7C4DFF)));
    canvas.drawCircle(const Offset(12.5, 18), 2.4, _fill(const Color(0xFF4FC3F7)));
    canvas.drawCircle(const Offset(19, 17.5), 2.2, _fill(const Color(0xFF81C784)));
    canvas.drawCircle(const Offset(11, 11), 2.5, _stroke..strokeWidth = 1.1);
    canvas.drawCircle(const Offset(18.5, 10), 2.3, _stroke..strokeWidth = 1.1);
    canvas.drawCircle(const Offset(12.5, 18), 2.4, _stroke..strokeWidth = 1.1);
    canvas.drawCircle(const Offset(19, 17.5), 2.2, _stroke..strokeWidth = 1.1);
  }

  void _star(Canvas canvas, {required bool lit}) {
    final core = lit ? const Color(0xFFFFF176) : const Color(0xFFB0BEC5);
    final tip = lit ? const Color(0xFFFF9800) : const Color(0xFF90A4AE);
    final path = Path();
    const n = 4;
    for (var i = 0; i < n * 2; i++) {
      final a = -math.pi / 2 + i * math.pi / n;
      final r = i.isEven ? 13.0 : 5.2;
      final p = Offset(16 + math.cos(a) * r, 16.2 + math.sin(a) * r);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, _fill(core));
    canvas.drawPath(path, _stroke);
    canvas.drawCircle(const Offset(16, 16.2), 3.4, _fill(tip));
    canvas.drawCircle(const Offset(16, 16.2), 3.4, _stroke..strokeWidth = 1.2);
    if (lit) {
      _spark(canvas, const Offset(26, 7), r: 2.1, color: const Color(0xFFFFF59D));
    }
  }

  void _gallery(Canvas canvas) {
    _blob(
      canvas,
      const Rect.fromLTWH(8.5, 3.5, 18, 16),
      const Color(0xFFFFB7D5),
      radius: 4,
    );
    _blob(
      canvas,
      const Rect.fromLTWH(3.5, 9.5, 20, 17.5),
      const Color(0xFFE1F5FE),
      radius: 4,
    );
    canvas.drawCircle(const Offset(18.5, 15.2), 2.1, _fill(const Color(0xFFFFF176)));
    final hill = Path()
      ..moveTo(6.2, 24)
      ..lineTo(11.5, 18.6)
      ..lineTo(15.2, 21.4)
      ..lineTo(20.8, 16.8)
      ..lineTo(23.2, 24)
      ..close();
    canvas.drawPath(hill, _fill(const Color(0xFF81C784)));
  }

  void _camera(Canvas canvas) {
    _blob(
      canvas,
      const Rect.fromLTWH(4, 9, 24, 16.5),
      const Color(0xFFFF8A80),
      radius: 5,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(12, 6.2, 8, 4.2),
        const Radius.circular(1.6),
      ),
      _fill(const Color(0xFFFFCC80)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(12, 6.2, 8, 4.2),
        const Radius.circular(1.6),
      ),
      _stroke..strokeWidth = 1.3,
    );
    canvas.drawCircle(const Offset(16, 17.4), 5.1, _fill(const Color(0xFF4FC3F7)));
    canvas.drawCircle(const Offset(16, 17.4), 5.1, _stroke);
    canvas.drawCircle(const Offset(16, 17.4), 2.2, _fill(const Color(0xFF1565C0)));
    canvas.drawCircle(const Offset(14.6, 16), 1.2, _fill(Colors.white.withValues(alpha: 0.85)));
    canvas.drawCircle(const Offset(23.8, 13.2), 1.3, _fill(const Color(0xFFFFF176)));
  }

  void _scan(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFE8F5E9), radius: 7);
    final ink = _fill(const Color(0xFF2E7D32));
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(8, 8, 6, 6), const Radius.circular(1.4)),
      ink,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(18, 8, 6, 6), const Radius.circular(1.4)),
      ink,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(8, 18, 6, 6), const Radius.circular(1.4)),
      ink,
    );
    canvas.drawRect(const Rect.fromLTWH(18, 18, 2.4, 2.4), _fill(const Color(0xFFFF6B9D)));
    canvas.drawRect(const Rect.fromLTWH(21.4, 18, 2.6, 2.6), _fill(const Color(0xFF7C4DFF)));
    canvas.drawRect(const Rect.fromLTWH(18, 21.4, 2.6, 2.6), _fill(const Color(0xFF4FC3F7)));
    canvas.drawRect(const Rect.fromLTWH(21.4, 21.6, 2.2, 2.2), _fill(const Color(0xFFFFE082)));
    _spark(canvas, const Offset(27, 6), r: 2.2);
  }

  void _settings(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFF90CAF9), radius: 7);
    canvas.save();
    canvas.translate(16, 16);
    for (var i = 0; i < 6; i++) {
      canvas.save();
      canvas.rotate(i * math.pi / 3);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-1.6, -9.4, 3.2, 5.4),
          const Radius.circular(1),
        ),
        _fill(const Color(0xFFE3F2FD)),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-1.6, -9.4, 3.2, 5.4),
          const Radius.circular(1),
        ),
        _stroke,
      );
      canvas.restore();
    }
    canvas.drawCircle(Offset.zero, 3.5, _fill(const Color(0xFFE3F2FD)));
    canvas.drawCircle(Offset.zero, 3.5, _stroke);
    canvas.drawCircle(Offset.zero, 1.4, _fill(_line));
    canvas.restore();
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _back(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFCC80), radius: 7);
    final chevron = Path()
      ..moveTo(19, 10.2)
      ..lineTo(12.2, 16)
      ..lineTo(19, 21.8);
    canvas.drawPath(chevron, _stroke..strokeWidth = 2.1);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _generate(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFF3E0), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(8, 8, 7, 7), const Radius.circular(1.5)),
      _fill(const Color(0xFFE65100)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(17, 8, 7, 7), const Radius.circular(1.5)),
      _fill(const Color(0xFFFF6B9D)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(8, 17, 7, 7), const Radius.circular(1.5)),
      _fill(const Color(0xFF7C4DFF)),
    );
    canvas.drawRect(const Rect.fromLTWH(17.2, 17.2, 3, 3), _fill(const Color(0xFF4FC3F7)));
    canvas.drawRect(const Rect.fromLTWH(21, 17.2, 3, 3), _fill(const Color(0xFF81C784)));
    canvas.drawRect(const Rect.fromLTWH(17.2, 21, 3, 3), _fill(const Color(0xFFFFE082)));
    canvas.drawRect(const Rect.fromLTWH(21, 21, 3, 3), _fill(const Color(0xFFE65100)));
  }

  void _caju(Canvas canvas) {
    _cajuFruit(canvas, qr: false);
  }

  void _cajuQr(Canvas canvas) {
    _cajuFruit(canvas, qr: true);
  }

  void _cajuFruit(Canvas canvas, {required bool qr}) {
    canvas.drawRect(const Rect.fromLTWH(15.1, 3.2, 1.8, 5.4), _fill(_line));
    final leafL = Path()
      ..moveTo(16, 2.4)
      ..lineTo(8.2, 6.2)
      ..lineTo(16, 8.2)
      ..close();
    final leafR = Path()
      ..moveTo(16, 2.4)
      ..lineTo(23.8, 6.2)
      ..lineTo(16, 8.2)
      ..close();
    canvas.drawPath(leafL, _fill(const Color(0xFF66BB6A)));
    canvas.drawPath(leafR, _fill(const Color(0xFF66BB6A)));
    canvas.drawPath(leafL, _stroke);
    canvas.drawPath(leafR, _stroke);
    _blob(canvas, const Rect.fromLTWH(5, 7.4, 22, 22), const Color(0xFFFF8A3D), radius: 6);
    canvas.drawCircle(const Offset(11.4, 16.2), 2.15, _fill(_line));
    canvas.drawCircle(const Offset(20.6, 16.2), 2.15, _fill(_line));
    canvas.drawCircle(const Offset(10.6, 15.4), 0.7, _fill(Colors.white));
    canvas.drawCircle(const Offset(19.8, 15.4), 0.7, _fill(Colors.white));
    final smile = Path()
      ..moveTo(12.4, 20.6)
      ..quadraticBezierTo(16, 23.6, 19.6, 20.6);
    canvas.drawPath(smile, _stroke..strokeWidth = 1.7);
    if (qr) {
      canvas.drawRect(const Rect.fromLTWH(7.4, 9.6, 5.4, 5.4), _fill(const Color(0xFFE65100)));
      canvas.drawRect(const Rect.fromLTWH(19.2, 9.6, 5.4, 5.4), _fill(const Color(0xFFE65100)));
      canvas.drawRect(const Rect.fromLTWH(7.4, 21.2, 5.4, 5.4), _fill(const Color(0xFFE65100)));
      canvas.drawRect(const Rect.fromLTWH(8.8, 11, 2.6, 2.6), _fill(const Color(0xFFFFF3E0)));
      canvas.drawRect(const Rect.fromLTWH(20.6, 11, 2.6, 2.6), _fill(const Color(0xFFFFF3E0)));
      canvas.drawRect(const Rect.fromLTWH(8.8, 22.6, 2.6, 2.6), _fill(const Color(0xFFFFF3E0)));
    }
  }

  void _history(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(3.5, 3.5, 25, 25), const Color(0xFFFFE0B2), radius: 12.5);
    canvas.drawCircle(const Offset(16, 16), 8.2, _fill(const Color(0xFFFFF8E1)));
    canvas.drawCircle(const Offset(16, 16), 8.2, _stroke);
    canvas.drawLine(const Offset(16, 16), const Offset(16, 10.6), _stroke..strokeWidth = 1.8);
    canvas.drawLine(const Offset(16, 16), const Offset(20.4, 17.6), _stroke..strokeWidth = 1.8);
    canvas.drawCircle(const Offset(16, 16), 1.3, _fill(_line));
    _spark(canvas, const Offset(26.2, 7), r: 2.1);
  }

  void _share(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFB3E5FC), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(10, 14.2, 12, 8.4), const Radius.circular(2.2)),
      _fill(const Color(0xFFE1F5FE)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(10, 14.2, 12, 8.4), const Radius.circular(2.2)),
      _stroke,
    );
    final arrow = Path()
      ..moveTo(16, 8.2)
      ..lineTo(20.2, 13.4)
      ..lineTo(17.2, 13.4)
      ..lineTo(17.2, 18.6)
      ..lineTo(14.8, 18.6)
      ..lineTo(14.8, 13.4)
      ..lineTo(11.8, 13.4)
      ..close();
    canvas.drawPath(arrow, _fill(const Color(0xFFFF8A80)));
    canvas.drawPath(arrow, _stroke);
    _spark(canvas, const Offset(26.2, 7), r: 2.1);
  }

  void _typeText(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFF59D), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9, 8, 14, 16), const Radius.circular(2.4)),
      _fill(const Color(0xFFFFFDE7)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9, 8, 14, 16), const Radius.circular(2.4)),
      _stroke,
    );
    final line = _stroke..strokeWidth = 1.5;
    canvas.drawLine(const Offset(12, 13), const Offset(20, 13), line);
    canvas.drawLine(const Offset(12, 16.6), const Offset(20, 16.6), line);
    canvas.drawLine(const Offset(12, 20.2), const Offset(17.4, 20.2), line);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeUrl(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFF80DEEA), radius: 7);
    void link(Rect rect) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        _fill(const Color(0xFFE0F7FA)),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        _stroke,
      );
    }
    link(const Rect.fromLTWH(7.6, 12.4, 10.4, 6.6));
    link(const Rect.fromLTWH(14, 12.4, 10.4, 6.6));
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeWifi(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFBBDEFB), radius: 7);
    final arc = _stroke..strokeWidth = 1.8;
    canvas.drawArc(const Rect.fromLTWH(8.2, 10.2, 15.6, 15.6), 3.7, 2.0, false, arc);
    canvas.drawArc(const Rect.fromLTWH(10.6, 12.8, 10.8, 10.8), 3.7, 2.0, false, arc);
    canvas.drawCircle(const Offset(16, 21.2), 1.6, _fill(const Color(0xFF1565C0)));
    canvas.drawCircle(const Offset(16, 21.2), 1.6, _stroke..strokeWidth = 1.2);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typePhone(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFAB91), radius: 7);
    canvas.save();
    canvas.translate(16, 16);
    canvas.rotate(-0.45);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-4.2, -9.4, 8.4, 18.8), const Radius.circular(2.6)),
      _fill(const Color(0xFFFFE0B2)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-4.2, -9.4, 8.4, 18.8), const Radius.circular(2.6)),
      _stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-2.6, -7.2, 5.2, 10.4), const Radius.circular(1.2)),
      _fill(const Color(0xFFFFF8E1)),
    );
    canvas.restore();
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeEmail(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFE1BEE7), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(7.6, 11, 16.8, 11.2), const Radius.circular(2.4)),
      _fill(const Color(0xFFF3E5F5)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(7.6, 11, 16.8, 11.2), const Radius.circular(2.4)),
      _stroke,
    );
    final flap = Path()
      ..moveTo(7.8, 12.2)
      ..lineTo(16, 18.2)
      ..lineTo(24.2, 12.2);
    canvas.drawPath(flap, _stroke);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _wifiLock(Canvas canvas, {required bool open}) {
    _blob(
      canvas,
      const Rect.fromLTWH(4, 4, 24, 24),
      open ? const Color(0xFFCFD8DC) : const Color(0xFFFFE0B2),
      radius: 7,
    );
    canvas.drawArc(const Rect.fromLTWH(11, 8.2, 10, 8.4), math.pi, math.pi, false, _stroke);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9.6, 13.4, 12.8, 9.4), const Radius.circular(2.6)),
      _fill(open ? const Color(0xFFECEFF1) : const Color(0xFFFFF8E1)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9.6, 13.4, 12.8, 9.4), const Radius.circular(2.6)),
      _stroke,
    );
    if (open) {
      canvas.drawLine(const Offset(12.6, 15.6), const Offset(19.4, 20.6), _stroke);
      canvas.drawLine(const Offset(19.4, 15.6), const Offset(12.6, 20.6), _stroke);
    } else {
      canvas.drawCircle(const Offset(16, 16.8), 1.3, _fill(_line));
      canvas.drawLine(const Offset(16, 17.8), const Offset(16, 20.2), _stroke);
    }
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _wifiShield(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFCC80), radius: 7);
    final shield = Path()
      ..moveTo(16, 8.4)
      ..lineTo(23.2, 11.2)
      ..lineTo(23.2, 17.4)
      ..quadraticBezierTo(23.2, 22.4, 16, 24.2)
      ..quadraticBezierTo(8.8, 22.4, 8.8, 17.4)
      ..lineTo(8.8, 11.2)
      ..close();
    canvas.drawPath(shield, _fill(const Color(0xFFFFF3E0)));
    canvas.drawPath(shield, _stroke);
    canvas.drawCircle(const Offset(16, 16.2), 2.1, _fill(const Color(0xFFFF8A80)));
    canvas.drawCircle(const Offset(16, 16.2), 2.1, _stroke..strokeWidth = 1.2);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _delete(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFAB91), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(10.2, 8.4, 11.6, 2.4), const Radius.circular(1)),
      _fill(const Color(0xFFFFCCBC)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(10.2, 8.4, 11.6, 2.4), const Radius.circular(1)),
      _stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(13.4, 6.6, 5.2, 2.4), const Radius.circular(0.8)),
      _fill(const Color(0xFFFFCCBC)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(10.6, 11.2, 10.8, 12.2), const Radius.circular(2)),
      _fill(const Color(0xFFFFE0B2)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(10.6, 11.2, 10.8, 12.2), const Radius.circular(2)),
      _stroke,
    );
    canvas.drawLine(const Offset(13.6, 13.6), const Offset(13.6, 20.4), _stroke);
    canvas.drawLine(const Offset(16, 13.6), const Offset(16, 20.4), _stroke);
    canvas.drawLine(const Offset(18.4, 13.6), const Offset(18.4, 20.4), _stroke);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _copy(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFB2DFDB), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9.2, 8.6, 11, 13.2), const Radius.circular(2)),
      _fill(const Color(0xFFE0F2F1)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9.2, 8.6, 11, 13.2), const Radius.circular(2)),
      _stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(11.8, 10.8, 11, 13.2), const Radius.circular(2)),
      _fill(const Color(0xFFE8F5E9)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(11.8, 10.8, 11, 13.2), const Radius.circular(2)),
      _stroke,
    );
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _search(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFC5CAE9), radius: 7);
    canvas.drawCircle(const Offset(14.4, 14.2), 5.2, _fill(const Color(0xFFE8EAF6)));
    canvas.drawCircle(const Offset(14.4, 14.2), 5.2, _stroke);
    canvas.drawLine(const Offset(18.2, 18.2), const Offset(23, 23), _stroke..strokeWidth = 2);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeSms(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFA5D6A7), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(8, 9.2, 16, 11.2), const Radius.circular(4)),
      _fill(const Color(0xFFE8F5E9)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(8, 9.2, 16, 11.2), const Radius.circular(4)),
      _stroke,
    );
    final tail = Path()
      ..moveTo(12, 20)
      ..lineTo(10.4, 24.2)
      ..lineTo(16.2, 20);
    canvas.drawPath(tail, _fill(const Color(0xFFE8F5E9)));
    canvas.drawPath(tail, _stroke);
    canvas.drawLine(const Offset(11.2, 13.4), const Offset(20.6, 13.4), _stroke);
    canvas.drawLine(const Offset(11.2, 16.6), const Offset(18.2, 16.6), _stroke);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeGeo(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFF81C784), radius: 7);
    final pin = Path()
      ..addOval(const Rect.fromLTWH(11.2, 8.2, 9.6, 9.6))
      ..moveTo(12.4, 16.2)
      ..lineTo(16, 24)
      ..lineTo(19.6, 16.2);
    canvas.drawPath(pin, _fill(const Color(0xFFFF8A80)));
    canvas.drawPath(pin, _stroke);
    canvas.drawCircle(const Offset(16, 13), 2.2, _fill(const Color(0xFFFFF8E1)));
    canvas.drawCircle(const Offset(16, 13), 2.2, _stroke..strokeWidth = 1.2);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeProduct(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFCC80), radius: 7);
    final bag = Path()
      ..moveTo(10.2, 13.2)
      ..lineTo(11.2, 23.2)
      ..lineTo(20.8, 23.2)
      ..lineTo(21.8, 13.2)
      ..close();
    canvas.drawPath(bag, _fill(const Color(0xFFFFE0B2)));
    canvas.drawPath(bag, _stroke);
    canvas.drawArc(const Rect.fromLTWH(12.2, 8.4, 7.6, 7.2), math.pi, math.pi, false, _stroke);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeContact(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFFFE082), radius: 7);
    canvas.drawCircle(const Offset(16, 13.2), 3.6, _fill(const Color(0xFFFFF8E1)));
    canvas.drawCircle(const Offset(16, 13.2), 3.6, _stroke);
    canvas.drawArc(const Rect.fromLTWH(9.6, 17.4, 12.8, 10), math.pi, math.pi, true, _fill(const Color(0xFFFFF8E1)));
    canvas.drawArc(const Rect.fromLTWH(9.6, 17.4, 12.8, 10), math.pi, math.pi, false, _stroke);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  void _typeIsbn(Canvas canvas) {
    _blob(canvas, const Rect.fromLTWH(4, 4, 24, 24), const Color(0xFFCE93D8), radius: 7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9, 8.4, 14, 16), const Radius.circular(2)),
      _fill(const Color(0xFFF3E5F5)),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(9, 8.4, 14, 16), const Radius.circular(2)),
      _stroke,
    );
    canvas.drawRect(const Rect.fromLTWH(9, 8.4, 2.4, 16), _fill(const Color(0xFF7E57C2)));
    canvas.drawLine(const Offset(13.6, 13), const Offset(20.6, 13), _stroke);
    canvas.drawLine(const Offset(13.6, 16.6), const Offset(20.6, 16.6), _stroke);
    _spark(canvas, const Offset(26, 7), r: 2.1);
  }

  @override
  bool shouldRepaint(covariant _AnimeIconPainter oldDelegate) {
    return oldDelegate.kind != kind;
  }
}

class _BusinessIconPainter extends CustomPainter {
  const _BusinessIconPainter({required this.kind, required this.color});

  final CajuIconKind kind;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    canvas.save();
    canvas.translate((size.width - s) / 2, (size.height - s) / 2);
    canvas.scale(s / 32);
    switch (kind) {
      case CajuIconKind.info:
        _info(canvas);
      case CajuIconKind.palette:
        _palette(canvas);
      case CajuIconKind.torchOn:
        _bolt(canvas, filled: true);
      case CajuIconKind.torchOff:
        _bolt(canvas, filled: false);
      case CajuIconKind.gallery:
        _gallery(canvas);
      case CajuIconKind.cameraSwitch:
        _camera(canvas);
      case CajuIconKind.scan:
        _scan(canvas);
      case CajuIconKind.generate:
        _generate(canvas);
      case CajuIconKind.cajuQr:
        _cajuQr(canvas);
      case CajuIconKind.caju:
        _caju(canvas);
      case CajuIconKind.history:
        _history(canvas);
      case CajuIconKind.settings:
        _settings(canvas);
      case CajuIconKind.back:
        _back(canvas);
      case CajuIconKind.share:
        _share(canvas);
      case CajuIconKind.typeText:
        _typeText(canvas);
      case CajuIconKind.typeUrl:
        _typeUrl(canvas);
      case CajuIconKind.typeWifi:
        _wifi(canvas);
      case CajuIconKind.typePhone:
        _phone(canvas);
      case CajuIconKind.typeEmail:
        _email(canvas);
      case CajuIconKind.wifiLock:
        _lock(canvas);
      case CajuIconKind.wifiShield:
        _shield(canvas);
      case CajuIconKind.wifiOpen:
        _lock(canvas);
      case CajuIconKind.delete:
        _delete(canvas);
      case CajuIconKind.copy:
        _copy(canvas);
      case CajuIconKind.search:
        _search(canvas);
      case CajuIconKind.typeSms:
        _sms(canvas);
      case CajuIconKind.typeGeo:
        _geo(canvas);
      case CajuIconKind.typeProduct:
        _product(canvas);
      case CajuIconKind.typeContact:
        _contact(canvas);
      case CajuIconKind.typeIsbn:
        _isbn(canvas);
    }
    canvas.restore();
  }

  Paint get _stroke => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.8
    ..strokeJoin = StrokeJoin.miter
    ..strokeMiterLimit = 4
    ..strokeCap = StrokeCap.butt
    ..isAntiAlias = true;

  Paint get _ink => Paint()
    ..color = color
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  void _box(Canvas canvas, Rect rect, {bool fill = false}) {
    canvas.drawRect(rect, fill ? _ink : _stroke);
  }

  void _info(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(6, 6, 20, 20));
    _box(canvas, const Rect.fromLTWH(15.1, 9.2, 1.8, 1.8), fill: true);
    canvas.drawLine(const Offset(16, 13.6), const Offset(16, 22.4), _stroke);
  }

  void _palette(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(6, 6, 20, 20));
    _box(canvas, const Rect.fromLTWH(10, 10, 4, 4), fill: true);
    _box(canvas, const Rect.fromLTWH(18, 10, 4, 4), fill: true);
    _box(canvas, const Rect.fromLTWH(10, 18, 4, 4), fill: true);
    _box(canvas, const Rect.fromLTWH(18, 18, 4, 4));
  }

  void _bolt(Canvas canvas, {required bool filled}) {
    final bolt = Path()
      ..moveTo(18.2, 6)
      ..lineTo(10.4, 16.4)
      ..lineTo(15.2, 16.4)
      ..lineTo(13.6, 26)
      ..lineTo(21.6, 14.8)
      ..lineTo(16.6, 14.8)
      ..close();
    canvas.drawPath(bolt, filled ? _ink : _stroke);
  }

  void _gallery(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(6, 8, 20, 16));
    _box(canvas, const Rect.fromLTWH(9.2, 11, 3.2, 3.2), fill: true);
    final hill = Path()
      ..moveTo(6, 24)
      ..lineTo(13, 16.4)
      ..lineTo(17.2, 20.6)
      ..lineTo(21.4, 15.6)
      ..lineTo(26, 24);
    canvas.drawPath(hill, _stroke);
  }

  void _camera(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(5.5, 11.2, 21, 13.6));
    _box(canvas, const Rect.fromLTWH(12.2, 7.6, 7.6, 3.6));
    _box(canvas, const Rect.fromLTWH(12.4, 14.2, 7.2, 7.2));
  }

  void _scan(Canvas canvas) {
    void corner(double x, double y, double dx, double dy) {
      canvas.drawLine(Offset(x, y), Offset(x + dx * 7, y), _stroke);
      canvas.drawLine(Offset(x, y), Offset(x, y + dy * 7), _stroke);
    }

    corner(6.5, 6.5, 1, 1);
    corner(25.5, 6.5, -1, 1);
    corner(6.5, 25.5, 1, -1);
    corner(25.5, 25.5, -1, -1);
    canvas.drawLine(const Offset(11, 16), const Offset(21, 16), _stroke);
  }

  void _generate(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(6, 6, 20, 20));
    _box(canvas, const Rect.fromLTWH(8.6, 8.6, 5.4, 5.4), fill: true);
    _box(canvas, const Rect.fromLTWH(18, 8.6, 5.4, 5.4), fill: true);
    _box(canvas, const Rect.fromLTWH(8.6, 18, 5.4, 5.4), fill: true);
    _box(canvas, const Rect.fromLTWH(18, 18, 2.2, 2.2), fill: true);
    _box(canvas, const Rect.fromLTWH(21.2, 18, 2.2, 2.2), fill: true);
    _box(canvas, const Rect.fromLTWH(18, 21.2, 2.2, 2.2), fill: true);
    _box(canvas, const Rect.fromLTWH(21.2, 21.2, 2.2, 2.2));
  }

  void _caju(Canvas canvas) {
    _cajuFruit(canvas, qr: false);
  }

  void _cajuQr(Canvas canvas) {
    _cajuFruit(canvas, qr: true);
  }

  Path _octagon(Rect rect, double cut) {
    return Path()
      ..moveTo(rect.left + cut, rect.top)
      ..lineTo(rect.right - cut, rect.top)
      ..lineTo(rect.right, rect.top + cut)
      ..lineTo(rect.right, rect.bottom - cut)
      ..lineTo(rect.right - cut, rect.bottom)
      ..lineTo(rect.left + cut, rect.bottom)
      ..lineTo(rect.left, rect.bottom - cut)
      ..lineTo(rect.left, rect.top + cut)
      ..close();
  }

  void _cajuFruit(Canvas canvas, {required bool qr}) {
    canvas.drawRect(const Rect.fromLTWH(15.15, 2.8, 1.7, 5.6), _ink);
    final leafL = Path()
      ..moveTo(16, 2.2)
      ..lineTo(7.6, 6.4)
      ..lineTo(16, 8.4)
      ..close();
    final leafR = Path()
      ..moveTo(16, 2.2)
      ..lineTo(24.4, 6.4)
      ..lineTo(16, 8.4)
      ..close();
    canvas.drawPath(leafL, _ink);
    canvas.drawPath(leafR, _ink);

    final body = qr
        ? const Rect.fromLTWH(4.6, 7.6, 22.8, 22.8)
        : const Rect.fromLTWH(5.2, 8, 21.6, 21.6);
    final shape = qr ? (Path()..addRect(body)) : _octagon(body, 3.2);

    canvas.saveLayer(body.inflate(1.2), Paint());
    canvas.drawPath(shape, _ink);

    final cut = Paint()
      ..blendMode = BlendMode.dstOut
      ..style = PaintingStyle.fill;

    if (qr) {
      void ring(double x, double y) {
        canvas.drawRect(Rect.fromLTWH(x + 1.35, y + 1.35, 3.9, 3.9), cut);
      }

      ring(5.4, 8.4);
      ring(20.6, 8.4);
      ring(5.4, 23.6);
    }

    if (qr) {
      canvas.drawRect(const Rect.fromLTWH(14.6, 16.2, 2.8, 3.6), cut);
      canvas.drawRect(const Rect.fromLTWH(18.8, 16.2, 2.8, 3.6), cut);
      final smile = Path()
        ..moveTo(14.4, 21.6)
        ..lineTo(17.4, 24.2)
        ..lineTo(20.4, 21.6)
        ..lineTo(19.2, 21.6)
        ..lineTo(17.4, 23.1)
        ..lineTo(15.6, 21.6)
        ..close();
      canvas.drawPath(smile, cut);
    } else {
      canvas.drawRect(const Rect.fromLTWH(9.2, 13.6, 4.4, 5.6), cut);
      canvas.drawRect(const Rect.fromLTWH(18.4, 13.6, 4.4, 5.6), cut);
      final smile = Path()
        ..moveTo(10.6, 21.4)
        ..lineTo(16, 25.4)
        ..lineTo(21.4, 21.4)
        ..lineTo(19.4, 21.4)
        ..lineTo(16, 23.8)
        ..lineTo(12.6, 21.4)
        ..close();
      canvas.drawPath(smile, cut);
    }
    canvas.restore();

    if (qr) {
      canvas.drawRect(const Rect.fromLTWH(7.55, 10.55, 2.4, 2.4), _ink);
      canvas.drawRect(const Rect.fromLTWH(22.75, 10.55, 2.4, 2.4), _ink);
      canvas.drawRect(const Rect.fromLTWH(7.55, 25.75, 2.4, 2.4), _ink);
      canvas.drawRect(const Rect.fromLTWH(15, 16.7, 1.3, 1.3), _ink);
      canvas.drawRect(const Rect.fromLTWH(19.2, 16.7, 1.3, 1.3), _ink);
    } else {
      canvas.drawRect(const Rect.fromLTWH(9.8, 14.2, 1.6, 1.6), _ink);
      canvas.drawRect(const Rect.fromLTWH(19, 14.2, 1.6, 1.6), _ink);
    }
  }

  void _history(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(6, 6, 20, 20));
    canvas.drawLine(const Offset(16, 16), const Offset(16, 10.4), _stroke);
    canvas.drawLine(const Offset(16, 16), const Offset(21.4, 19.2), _stroke);
    _box(canvas, const Rect.fromLTWH(15.1, 15.1, 1.8, 1.8), fill: true);
  }

  void _settings(Canvas canvas) {
    canvas.save();
    canvas.translate(16, 16);
    final hex = Path();
    for (var i = 0; i < 6; i++) {
      final a = -math.pi / 2 + i * math.pi / 3;
      final p = Offset(math.cos(a) * 10.4, math.sin(a) * 10.4);
      if (i == 0) {
        hex.moveTo(p.dx, p.dy);
      } else {
        hex.lineTo(p.dx, p.dy);
      }
    }
    hex.close();
    canvas.drawPath(hex, _stroke);
    canvas.drawRect(const Rect.fromLTWH(-3, -3, 6, 6), _ink);
    canvas.restore();
  }

  void _back(Canvas canvas) {
    final chevron = Path()
      ..moveTo(20.2, 7.4)
      ..lineTo(10.2, 16)
      ..lineTo(20.2, 24.6);
    canvas.drawPath(chevron, _stroke..strokeWidth = 2);
  }

  void _share(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(7.5, 14, 17, 10.5));
    final arrow = Path()
      ..moveTo(16, 6)
      ..lineTo(21.4, 12.6)
      ..lineTo(17.4, 12.6)
      ..lineTo(17.4, 19)
      ..lineTo(14.6, 19)
      ..lineTo(14.6, 12.6)
      ..lineTo(10.6, 12.6)
      ..close();
    canvas.drawPath(arrow, _ink);
  }

  void _typeText(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(7, 6, 18, 20));
    canvas.drawLine(const Offset(10.6, 12.6), const Offset(21.4, 12.6), _stroke);
    canvas.drawLine(const Offset(10.6, 17.2), const Offset(21.4, 17.2), _stroke);
    canvas.drawLine(const Offset(10.6, 21.8), const Offset(17.2, 21.8), _stroke);
  }

  void _typeUrl(Canvas canvas) {
    canvas.save();
    canvas.translate(16, 16);
    canvas.rotate(-0.55);
    _box(canvas, const Rect.fromLTWH(-10, -3.2, 12, 6.4));
    _box(canvas, const Rect.fromLTWH(-2, -3.2, 12, 6.4));
    canvas.restore();
  }

  void _wifi(Canvas canvas) {
    void chevron(double top, double half) {
      final path = Path()
        ..moveTo(16 - half, top + half * 0.55)
        ..lineTo(16, top)
        ..lineTo(16 + half, top + half * 0.55);
      canvas.drawPath(path, _stroke);
    }

    chevron(8.4, 10.4);
    chevron(13.2, 6.8);
    _box(canvas, const Rect.fromLTWH(14.6, 20.4, 2.8, 2.8), fill: true);
  }

  void _phone(Canvas canvas) {
    canvas.save();
    canvas.translate(16, 16);
    canvas.rotate(-0.45);
    _box(canvas, const Rect.fromLTWH(-5.2, -10.2, 10.4, 20.4));
    _box(canvas, const Rect.fromLTWH(-3.2, -7.4, 6.4, 12));
    canvas.restore();
  }

  void _email(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(5, 9.2, 22, 14.2));
    final flap = Path()
      ..moveTo(5, 9.2)
      ..lineTo(16, 18.4)
      ..lineTo(27, 9.2);
    canvas.drawPath(flap, _stroke);
  }

  void _lock(Canvas canvas) {
    canvas.drawRect(const Rect.fromLTWH(11.2, 7.2, 9.6, 7.2), _stroke);
    canvas.drawLine(const Offset(11.2, 11.2), const Offset(11.2, 7.2), _stroke);
    _box(canvas, const Rect.fromLTWH(8.4, 13.2, 15.2, 11.2));
    _box(canvas, const Rect.fromLTWH(15.1, 16.8, 1.8, 4.2), fill: true);
  }

  void _shield(Canvas canvas) {
    final shield = Path()
      ..moveTo(16, 5.6)
      ..lineTo(25.2, 9.4)
      ..lineTo(25.2, 17.2)
      ..lineTo(16, 26.2)
      ..lineTo(6.8, 17.2)
      ..lineTo(6.8, 9.4)
      ..close();
    canvas.drawPath(shield, _stroke);
  }

  void _delete(Canvas canvas) {
    canvas.drawLine(const Offset(9.6, 9.4), const Offset(22.4, 9.4), _stroke);
    _box(canvas, const Rect.fromLTWH(13.2, 6, 5.6, 3.4));
    _box(canvas, const Rect.fromLTWH(9.4, 11, 13.2, 14.4));
    canvas.drawLine(const Offset(13.2, 14.2), const Offset(13.2, 21.6), _stroke);
    canvas.drawLine(const Offset(16, 14.2), const Offset(16, 21.6), _stroke);
    canvas.drawLine(const Offset(18.8, 14.2), const Offset(18.8, 21.6), _stroke);
  }

  void _copy(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(7, 7, 13.6, 15.6));
    _box(canvas, const Rect.fromLTWH(11.4, 10.4, 13.6, 15.6));
  }

  void _search(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(6.8, 6.8, 13.6, 13.6));
    canvas.drawLine(const Offset(18.8, 18.8), const Offset(25.2, 25.2), _stroke..strokeWidth = 2);
  }

  void _sms(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(6, 7.2, 20, 13.6));
    final tail = Path()
      ..moveTo(10.4, 20.8)
      ..lineTo(8.2, 26)
      ..lineTo(16.4, 20.8);
    canvas.drawPath(tail, _stroke);
  }

  void _geo(Canvas canvas) {
    final pin = Path()
      ..moveTo(16, 5.6)
      ..lineTo(24.4, 14.8)
      ..lineTo(16, 26.4)
      ..lineTo(7.6, 14.8)
      ..close();
    canvas.drawPath(pin, _stroke);
    _box(canvas, const Rect.fromLTWH(14.2, 12.4, 3.6, 3.6), fill: true);
  }

  void _product(Canvas canvas) {
    final bag = Path()
      ..moveTo(9, 13)
      ..lineTo(10.4, 25.2)
      ..lineTo(21.6, 25.2)
      ..lineTo(23, 13)
      ..close();
    canvas.drawPath(bag, _stroke);
    canvas.drawLine(const Offset(12.2, 13), const Offset(12.2, 9.2), _stroke);
    canvas.drawLine(const Offset(12.2, 9.2), const Offset(19.8, 9.2), _stroke);
    canvas.drawLine(const Offset(19.8, 9.2), const Offset(19.8, 13), _stroke);
  }

  void _contact(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(11.2, 6.4, 9.6, 9.6));
    final body = Path()
      ..moveTo(7.2, 26)
      ..lineTo(10.4, 17.4)
      ..lineTo(21.6, 17.4)
      ..lineTo(24.8, 26);
    canvas.drawPath(body, _stroke);
  }

  void _isbn(Canvas canvas) {
    _box(canvas, const Rect.fromLTWH(7.5, 6, 17, 20));
    canvas.drawLine(const Offset(11.2, 6), const Offset(11.2, 26), _stroke);
    canvas.drawLine(const Offset(14.4, 12.8), const Offset(21.4, 12.8), _stroke);
    canvas.drawLine(const Offset(14.4, 17.4), const Offset(21.4, 17.4), _stroke);
  }

  @override
  bool shouldRepaint(covariant _BusinessIconPainter oldDelegate) {
    return oldDelegate.kind != kind || oldDelegate.color != color;
  }
}
