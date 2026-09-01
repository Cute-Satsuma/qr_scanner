import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner/database/scan_record.dart';
import 'package:qr_scanner/l10n/generated/app_localizations.dart';
import 'package:qr_scanner/theme/caju_icons.dart';
import 'package:qr_scanner/theme/caju_qr.dart';
import 'package:qr_scanner/theme/caju_style.dart';
import 'package:qr_scanner/utils/content_parser.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showScanResultSheet(BuildContext context, ScanRecord record) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => ScanResultSheet(record: record),
  );
}

class ScanResultSheet extends StatelessWidget {
  const ScanResultSheet({super.key, required this.record});

  final ScanRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final parsed = parseContent(
      record.rawValue,
      hintedType: record.contentType,
    );
    final colorScheme = Theme.of(context).colorScheme;
    final icon = cajuIconForContent(parsed.kind.name);
    final typeLabel = _typeLabel(l10n, parsed.kind);

    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
                  child: CajuAnimeIcon(kind: icon, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.isGenerated
                            ? l10n.generateResult
                            : l10n.scanResult,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${record.isGenerated ? l10n.generateTab : l10n.scanTab} · $typeLabel · ${l10n.formatLabel(record.format)}',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: cajuPanelDecoration(
                colorScheme,
                color: colorScheme.surfaceContainerLow,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  record.rawValue,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            if (record.isGenerated) ...[
              const SizedBox(height: 16),
              Center(
                child: CajuQrView(
                  data: record.rawValue,
                  size: 168,
                ),
              ),
            ],
            if (parsed.kind == ContentKind.wifi &&
                parsed.extras.isNotEmpty) ...[
              const SizedBox(height: 12),
              if (parsed.extras['ssid'] != null)
                _InfoLine(label: l10n.ssidLabel, value: parsed.extras['ssid']!),
              if (parsed.extras['password'] != null)
                _InfoLine(
                  label: l10n.passwordLabel,
                  value: parsed.extras['password']!,
                ),
            ],
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ActionChip(
                  icon: CajuIconKind.copy,
                  label: l10n.copy,
                  onTap: () => _copy(context, record.rawValue, l10n.copied),
                ),
                _ActionChip(
                  icon: CajuIconKind.share,
                  label: l10n.share,
                  onTap: () => SharePlus.instance.share(
                    ShareParams(text: record.rawValue),
                  ),
                ),
                if (parsed.kind == ContentKind.url)
                  _ActionChip(
                    icon: CajuIconKind.typeUrl,
                    label: l10n.openLink,
                    onTap: () => _open(record.rawValue),
                  ),
                if (parsed.kind == ContentKind.phone)
                  _ActionChip(
                    icon: CajuIconKind.typePhone,
                    label: l10n.callNumber,
                    onTap: () => _open(
                      record.rawValue.startsWith('tel:')
                          ? record.rawValue
                          : 'tel:${record.rawValue}',
                    ),
                  ),
                if (parsed.kind == ContentKind.email)
                  _ActionChip(
                    icon: CajuIconKind.typeEmail,
                    label: l10n.sendEmail,
                    onTap: () => _open(
                      record.rawValue.toLowerCase().startsWith('mailto:')
                          ? record.rawValue
                          : 'mailto:${record.rawValue}',
                    ),
                  ),
                if (parsed.kind == ContentKind.sms)
                  _ActionChip(
                    icon: CajuIconKind.typeSms,
                    label: l10n.sendSms,
                    onTap: () => _open(record.rawValue),
                  ),
                if (parsed.kind == ContentKind.wifi &&
                    parsed.extras['password'] != null)
                  _ActionChip(
                    icon: CajuIconKind.wifiLock,
                    label: l10n.passwordLabel,
                    onTap: () =>
                        _copy(context, parsed.extras['password']!, l10n.copied),
                  ),
                if (parsed.kind == ContentKind.text ||
                    parsed.kind == ContentKind.product ||
                    parsed.kind == ContentKind.isbn)
                  _ActionChip(
                    icon: CajuIconKind.search,
                    label: l10n.searchWeb,
                    onTap: () => _open(
                      'https://www.google.com/search?q=${Uri.encodeQueryComponent(record.rawValue)}',
                    ),
                  ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }

  static String _typeLabel(AppLocalizations l10n, ContentKind kind) {
    switch (kind) {
      case ContentKind.url:
        return l10n.typeUrl;
      case ContentKind.wifi:
        return l10n.typeWifi;
      case ContentKind.phone:
        return l10n.typePhone;
      case ContentKind.email:
        return l10n.typeEmail;
      case ContentKind.sms:
        return l10n.typeSms;
      case ContentKind.geo:
        return l10n.typeGeo;
      case ContentKind.product:
        return l10n.typeProduct;
      case ContentKind.contact:
        return l10n.typeContact;
      case ContentKind.isbn:
        return l10n.typeIsbn;
      case ContentKind.text:
        return l10n.typeText;
    }
  }

  static Future<void> _copy(
    BuildContext context,
    String value,
    String copied,
  ) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(copied)));
  }

  static Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final CajuIconKind icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: CajuAnimeIcon(kind: icon, size: 22),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
