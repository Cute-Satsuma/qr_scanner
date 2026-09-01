import 'package:flutter/material.dart';

enum AppPalette { orange, green, teal, blue, slate, paper }

enum AppBrightnessMode { system, light, dark }

enum AppTypeface { rounded, maru, xiaowei, nunito, system }

enum AppIconStyle { anime, business }

class PaletteSpec {
  const PaletteSpec({
    required this.primary,
    required this.primarySoft,
    required this.seedLight,
    required this.seedDark,
  });

  final Color primary;
  final Color primarySoft;
  final Color seedLight;
  final Color seedDark;
}

const paletteSpecs = <AppPalette, PaletteSpec>{
  AppPalette.orange: PaletteSpec(
    primary: Color(0xFFE65100),
    primarySoft: Color(0xFFFFB74D),
    seedLight: Color(0xFFBF360C),
    seedDark: Color(0xFFFF9800),
  ),
  AppPalette.green: PaletteSpec(
    primary: Color(0xFF2E7D32),
    primarySoft: Color(0xFF81C784),
    seedLight: Color(0xFF1B5E20),
    seedDark: Color(0xFF4CAF50),
  ),
  AppPalette.teal: PaletteSpec(
    primary: Color(0xFF00897B),
    primarySoft: Color(0xFF80CBC4),
    seedLight: Color(0xFF004D40),
    seedDark: Color(0xFF26A69A),
  ),
  AppPalette.blue: PaletteSpec(
    primary: Color(0xFF1565C0),
    primarySoft: Color(0xFF90CAF9),
    seedLight: Color(0xFF0D47A1),
    seedDark: Color(0xFF42A5F5),
  ),
  AppPalette.slate: PaletteSpec(
    primary: Color(0xFF455A64),
    primarySoft: Color(0xFF90A4AE),
    seedLight: Color(0xFF263238),
    seedDark: Color(0xFF78909C),
  ),
  AppPalette.paper: PaletteSpec(
    primary: Color(0xFF6D4C41),
    primarySoft: Color(0xFFD7CCC8),
    seedLight: Color(0xFF4E342E),
    seedDark: Color(0xFFA1887F),
  ),
};

class CajuThemeExtras extends ThemeExtension<CajuThemeExtras> {
  const CajuThemeExtras({
    required this.overlayAccent,
    required this.glyphColor,
    this.paperFilter = false,
  });

  final Color overlayAccent;
  final Color glyphColor;
  final bool paperFilter;

  @override
  CajuThemeExtras copyWith({
    Color? overlayAccent,
    Color? glyphColor,
    bool? paperFilter,
  }) {
    return CajuThemeExtras(
      overlayAccent: overlayAccent ?? this.overlayAccent,
      glyphColor: glyphColor ?? this.glyphColor,
      paperFilter: paperFilter ?? this.paperFilter,
    );
  }

  @override
  CajuThemeExtras lerp(ThemeExtension<CajuThemeExtras>? other, double t) {
    if (other is! CajuThemeExtras) return this;
    return CajuThemeExtras(
      overlayAccent: Color.lerp(overlayAccent, other.overlayAccent, t)!,
      glyphColor: Color.lerp(glyphColor, other.glyphColor, t)!,
      paperFilter: t < 0.5 ? paperFilter : other.paperFilter,
    );
  }

  static Color of(BuildContext context) {
    return Theme.of(context).extension<CajuThemeExtras>()?.overlayAccent ??
        Theme.of(context).colorScheme.primary;
  }

  static Color glyphOf(BuildContext context) {
    return Theme.of(context).extension<CajuThemeExtras>()?.glyphColor ??
        Theme.of(context).colorScheme.primary;
  }
}

ThemeMode themeModeOf(AppBrightnessMode mode) {
  switch (mode) {
    case AppBrightnessMode.system:
      return ThemeMode.system;
    case AppBrightnessMode.light:
      return ThemeMode.light;
    case AppBrightnessMode.dark:
      return ThemeMode.dark;
  }
}
