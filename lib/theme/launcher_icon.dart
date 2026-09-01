import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner/theme/app_palette.dart';

const _channel = MethodChannel('com.bytemyth.qr_scanner/launcher_icon');

/// Keeps the home-screen icon in sync with [AppIconStyle].
///
/// Android uses activity-aliases; iOS uses alternate icons (system alert).
Future<void> syncLauncherIcon(AppIconStyle style) async {
  if (kIsWeb) return;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      break;
    default:
      return;
  }
  try {
    await _channel.invokeMethod<void>('setIcon', style.name);
  } on MissingPluginException {
    // widget tests / platforms without the channel
  } on PlatformException {
    // iOS may reject while an icon change is already in flight
  }
}
