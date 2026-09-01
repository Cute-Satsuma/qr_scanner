import 'package:flutter/material.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/launcher_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController({
    this.palette = AppPalette.orange,
    this.brightnessMode = AppBrightnessMode.system,
    this.typeface = AppTypeface.rounded,
    this.iconStyle = AppIconStyle.anime,
    this.paperFilter = false,
    double paperGrain = defaultPaperGrain,
  }) : paperGrain = ValueNotifier(paperGrain.clamp(0.0, 1.0));

  static const defaultPaperGrain = 0.35;
  static const _paletteKey = 'app_palette_v1';
  static const _brightnessKey = 'app_brightness_v1';
  static const _typefaceKey = 'app_typeface_v1';
  static const _iconStyleKey = 'app_icon_style_v1';
  static const _paperFilterKey = 'app_paper_filter_v1';
  static const _paperGrainKey = 'app_paper_grain_v1';

  AppPalette palette;
  AppBrightnessMode brightnessMode;
  AppTypeface typeface;
  AppIconStyle iconStyle;
  bool paperFilter;
  final ValueNotifier<double> paperGrain;

  ThemeMode get themeMode => themeModeOf(brightnessMode);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final paletteName = prefs.getString(_paletteKey);
    final brightnessName = prefs.getString(_brightnessKey);
    final typefaceName = prefs.getString(_typefaceKey);
    final iconStyleName = prefs.getString(_iconStyleKey);
    final storedFilter = prefs.getBool(_paperFilterKey);
    final storedGrain = prefs.getDouble(_paperGrainKey);
    var changed = false;
    if (paletteName != null) {
      final match = AppPalette.values
          .where((item) => item.name == paletteName)
          .firstOrNull;
      if (match != null && match != palette) {
        palette = match;
        changed = true;
      }
    }
    if (brightnessName != null) {
      final match = AppBrightnessMode.values
          .where((item) => item.name == brightnessName)
          .firstOrNull;
      if (match != null && match != brightnessMode) {
        brightnessMode = match;
        changed = true;
      }
    }
    if (typefaceName != null) {
      final match = AppTypeface.values
          .where((item) => item.name == typefaceName)
          .firstOrNull;
      if (match != null && match != typeface) {
        typeface = match;
        changed = true;
      }
    }
    if (iconStyleName != null) {
      final match = AppIconStyle.values
          .where((item) => item.name == iconStyleName)
          .firstOrNull;
      if (match != null && match != iconStyle) {
        iconStyle = match;
        changed = true;
      }
    }
    final nextFilter = storedFilter ?? (palette == AppPalette.paper);
    if (nextFilter != paperFilter) {
      paperFilter = nextFilter;
      changed = true;
    }
    if (storedGrain != null) {
      final nextGrain = storedGrain.clamp(0.0, 1.0);
      if ((paperGrain.value - nextGrain).abs() > 0.0008) {
        paperGrain.value = nextGrain;
      }
    }
    if (changed) notifyListeners();
    await syncLauncherIcon(iconStyle);
  }

  Future<void> setPaperGrain(double value, {bool persist = false}) async {
    final next = value.clamp(0.0, 1.0);
    if ((paperGrain.value - next).abs() > 0.0008) {
      paperGrain.value = next;
    }
    if (!persist) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_paperGrainKey, paperGrain.value);
  }

  Future<void> setPaperFilter(bool value) async {
    if (paperFilter == value) return;
    paperFilter = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_paperFilterKey, value);
  }

  Future<void> setTypeface(AppTypeface value) async {
    if (typeface == value) return;
    typeface = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_typefaceKey, value.name);
  }

  Future<void> setIconStyle(AppIconStyle value) async {
    if (iconStyle == value) return;
    iconStyle = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_iconStyleKey, value.name);
    await syncLauncherIcon(value);
  }

  Future<void> setPalette(AppPalette value) async {
    if (palette == value) return;
    palette = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_paletteKey, value.name);
  }

  Future<void> setBrightnessMode(AppBrightnessMode value) async {
    if (brightnessMode == value) return;
    brightnessMode = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_brightnessKey, value.name);
  }
}

class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'ThemeScope not found');
    return scope!.notifier!;
  }
}
