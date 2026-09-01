import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/caju_fonts.dart';

ThemeData buildAppTheme(
  AppPalette palette,
  Brightness brightness, {
  AppTypeface typeface = AppTypeface.rounded,
  bool paperFilter = false,
}) {
  final isDark = brightness == Brightness.dark;
  final spec = paletteSpecs[palette]!;
  var colorScheme = ColorScheme.fromSeed(
    seedColor: isDark ? spec.seedDark : spec.seedLight,
    brightness: brightness,
    primary: isDark ? spec.primarySoft : spec.primary,
  );
  if (palette == AppPalette.paper) {
    colorScheme = isDark
        ? colorScheme.copyWith(
            surface: const Color(0xFF2A2218),
            surfaceContainerLowest: const Color(0xFF231C14),
            surfaceContainerLow: const Color(0xFF33291C),
            surfaceContainer: const Color(0xFF3B2F20),
            surfaceContainerHigh: const Color(0xFF443628),
            onSurface: const Color(0xFFE8D9C0),
            onSurfaceVariant: const Color(0xFFC4B49A),
            outlineVariant: const Color(0xFF6B5840),
          )
        : colorScheme.copyWith(
            surface: const Color(0xFFF3E6CF),
            surfaceContainerLowest: const Color(0xFFF8EFD9),
            surfaceContainerLow: const Color(0xFFEAD9B8),
            surfaceContainer: const Color(0xFFE6D3B0),
            surfaceContainerHigh: const Color(0xFFDCC8A2),
            onSurface: const Color(0xFF3E2F1C),
            onSurfaceVariant: const Color(0xFF6B5840),
            outlineVariant: const Color(0xFFC4B08A),
          );
  }
  final radius28 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(28),
  );
  final baseText = ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    brightness: brightness,
  ).textTheme;
  final textTheme = cuteTextTheme(baseText, typeface);
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    textTheme: textTheme,
    primaryTextTheme: cuteTextTheme(baseText, typeface),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme.primary,
      surfaceTintColor: Colors.transparent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: radius28,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerLowest,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.7),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      height: 68,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      indicatorColor: colorScheme.primary.withValues(alpha: 0.14),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return textTheme.labelSmall?.copyWith(
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          letterSpacing: 0.2,
        );
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.primary,
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: colorScheme.surface,
      modalBackgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
    ),
    extensions: <ThemeExtension<dynamic>>[
      CajuThemeExtras(
        overlayAccent: spec.primarySoft,
        glyphColor: spec.primary,
        paperFilter: paperFilter,
      ),
    ],
  );
}

TextStyle cajuCenterHintStyle(BuildContext context, {required Color color}) {
  final base = Theme.of(context).textTheme.bodyMedium;
  return TextStyle(
    inherit: false,
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.2,
    fontFamily: base?.fontFamily,
    fontFamilyFallback: base?.fontFamilyFallback,
    fontStyle: base?.fontStyle,
  );
}

class CajuCenterHint extends StatelessWidget {
  const CajuCenterHint({
    super.key,
    required this.text,
    this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: cajuCenterHintStyle(
          context,
          color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

double cajuStageSide(BoxConstraints constraints, {double captionBlock = 0}) {
  return [
    288.0,
    constraints.maxWidth,
    constraints.maxHeight - captionBlock,
  ].reduce(math.min).clamp(168.0, 288.0);
}

/// 扫码相机故障、生成页空状态中间图标的边长。
const double cajuEmptyMarkSize = 64.0;

class CajuWash extends StatelessWidget {
  const CajuWash({super.key, this.height = 220, this.child});

  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.primary.withValues(alpha: 0.12),
                  colorScheme.primary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        ?child,
      ],
    );
  }
}

class CajuPageTitle extends StatelessWidget {
  const CajuPageTitle({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.color,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final titleColor = color ?? Theme.of(context).colorScheme.primary;
    Widget slot({required Widget child}) {
      return SizedBox(width: 40, height: 40, child: child);
    }

    return Row(
      children: [
        slot(child: leading ?? const SizedBox.shrink()),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
                color: titleColor,
              ),
            ),
          ),
        ),
        slot(child: trailing ?? const SizedBox.shrink()),
      ],
    );
  }
}

BoxDecoration cajuPanelDecoration(ColorScheme colorScheme, {Color? color}) {
  return BoxDecoration(
    color: color ?? colorScheme.surface,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: colorScheme.outlineVariant.withValues(alpha: 0.45),
    ),
  );
}

class CajuTabShell extends StatelessWidget {
  const CajuTabShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.10),
            blurRadius: 22,
            offset: const Offset(0, -6),
          ),
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 14,
              width: double.infinity,
              child: CustomPaint(
                painter: _TabDividerPainter(
                  color: colorScheme.primary,
                  sparkle: CajuThemeExtras.of(context),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class _TabDividerPainter extends CustomPainter {
  const _TabDividerPainter({required this.color, required this.sparkle});

  final Color color;
  final Color sparkle;

  @override
  void paint(Canvas canvas, Size size) {
    final cy = size.height * 0.55;
    final start = Offset(size.width * 0.08, cy);
    final end = Offset(size.width * 0.92, cy);
    final line = Paint()
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [
          color.withValues(alpha: 0),
          color.withValues(alpha: 0.38),
          color.withValues(alpha: 0.38),
          color.withValues(alpha: 0),
        ],
        stops: const [0, 0.22, 0.78, 1],
      ).createShader(Rect.fromPoints(start, end));
    canvas.drawLine(start, end, line);

    final mid = Offset(size.width / 2, cy);
    final gem = Path();
    const r = 3.4;
    for (var i = 0; i < 8; i++) {
      final a = -1.5708 + i * 0.7854;
      final radius = i.isEven ? r : r * 0.38;
      final p = Offset(
        mid.dx + math.cos(a) * radius,
        mid.dy + math.sin(a) * radius,
      );
      if (i == 0) {
        gem.moveTo(p.dx, p.dy);
      } else {
        gem.lineTo(p.dx, p.dy);
      }
    }
    gem.close();
    canvas.drawPath(gem, Paint()..color = sparkle);
    canvas.drawPath(
      gem,
      Paint()
        ..color = const Color(0xFF4E342E).withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );
  }

  @override
  bool shouldRepaint(covariant _TabDividerPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.sparkle != sparkle;
  }
}

class CajuActionCircle extends StatelessWidget {
  const CajuActionCircle({
    super.key,
    required this.child,
    this.selected = false,
    this.size = 48,
  });

  final Widget child;
  final bool selected;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected
            ? colorScheme.primary.withValues(alpha: 0.14)
            : colorScheme.surfaceContainerLow,
        border: Border.all(
          color: selected
              ? colorScheme.primary
              : colorScheme.outline.withValues(alpha: 0.22),
          width: selected ? 2 : 1,
        ),
      ),
      child: Center(child: child),
    );
  }
}

class CajuStampButton extends StatelessWidget {
  const CajuStampButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.selected = false,
    this.tooltip,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onTap;
  final bool selected;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final stamp = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            CajuActionCircle(selected: selected, child: icon),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: selected
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (tooltip == null) return stamp;
    return Tooltip(message: tooltip!, child: stamp);
  }
}

class CajuRoundAction extends StatelessWidget {
  const CajuRoundAction({
    super.key,
    required this.child,
    required this.tooltip,
    this.label,
    this.labelColor,
    this.onTap,
    this.active = false,
  });

  final Widget child;
  final String tooltip;
  final String? label;
  final Color? labelColor;
  final VoidCallback? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final button = Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: CajuActionCircle(selected: active, child: child),
        ),
      ),
    );
    if (label == null) return button;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          button,
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label!,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: labelColor ??
                    (active
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant),
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
