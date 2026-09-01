import 'package:flutter/material.dart';
import 'package:qr_scanner/generate/generate_page.dart';
import 'package:qr_scanner/l10n/generated/app_localizations.dart';
import 'package:qr_scanner/scan/scan_page.dart';
import 'package:qr_scanner/settings/settings_page.dart';
import 'package:qr_scanner/theme/caju_icons.dart';
import 'package:qr_scanner/theme/caju_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: IndexedStack(
        index: _index,
        children: [
          ScanPage(active: _index == 0),
          const GeneratePage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: CajuTabShell(
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: [
            NavigationDestination(
              icon: const CajuAnimeIcon(
                kind: CajuIconKind.scan,
                size: 26,
                dimmed: true,
              ),
              selectedIcon: const CajuAnimeIcon(
                kind: CajuIconKind.scan,
                size: 26,
              ),
              label: l10n.scanTab,
            ),
            NavigationDestination(
              icon: const CajuAnimeIcon(
                kind: CajuIconKind.generate,
                size: 26,
                dimmed: true,
              ),
              selectedIcon: const CajuAnimeIcon(
                kind: CajuIconKind.generate,
                size: 26,
              ),
              label: l10n.generateTab,
            ),
            NavigationDestination(
              icon: const CajuAnimeIcon(
                kind: CajuIconKind.settings,
                size: 26,
                dimmed: true,
              ),
              selectedIcon: const CajuAnimeIcon(
                kind: CajuIconKind.settings,
                size: 26,
              ),
              label: l10n.settingsTab,
            ),
          ],
        ),
      ),
    );
  }
}
