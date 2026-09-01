import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qr_scanner/database/db_init.dart';
import 'package:qr_scanner/home/home_page.dart';
import 'package:qr_scanner/l10n/generated/app_localizations.dart';
import 'package:qr_scanner/theme/caju_style.dart';
import 'package:qr_scanner/theme/launcher_icon.dart';
import 'package:qr_scanner/theme/paper_filter.dart';
import 'package:qr_scanner/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabaseFactory();
  final themeController = ThemeController();
  await themeController.load();
  // Android 15+ 默认无边框；低版本需显式打开，状态栏/导航栏才会叠在内容上并由 SafeArea 让位。
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(QrScannerApp(themeController: themeController));
}

class QrScannerApp extends StatefulWidget {
  const QrScannerApp({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  State<QrScannerApp> createState() => _QrScannerAppState();
}

class _QrScannerAppState extends State<QrScannerApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncLauncherIcon(widget.themeController.iconStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = widget.themeController;
    return ThemeScope(
      controller: themeController,
      child: ListenableBuilder(
        listenable: themeController,
        builder: (context, _) {
          return MaterialApp(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)?.appName ?? 'QR Scan Caju',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('zh', 'CN'),
              Locale('es'),
              Locale('hi'),
              Locale('ar'),
              Locale('pt'),
              Locale('bn'),
              Locale('ru'),
              Locale('ja'),
              Locale('de'),
            ],
            theme: buildAppTheme(
              themeController.palette,
              Brightness.light,
              typeface: themeController.typeface,
              paperFilter: themeController.paperFilter,
            ),
            darkTheme: buildAppTheme(
              themeController.palette,
              Brightness.dark,
              typeface: themeController.typeface,
              paperFilter: themeController.paperFilter,
            ),
            themeMode: themeController.themeMode,
            builder: (context, child) {
              final brightness = Theme.of(context).brightness;
              final darkIcons = brightness == Brightness.light;
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                  statusBarIconBrightness: darkIcons
                      ? Brightness.dark
                      : Brightness.light,
                  systemNavigationBarIconBrightness: darkIcons
                      ? Brightness.dark
                      : Brightness.light,
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarContrastEnforced: false,
                ),
                child: PaperFilterOverlay(
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
