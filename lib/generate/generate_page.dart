import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_scanner/database/database_helper.dart';
import 'package:qr_scanner/database/scan_record.dart';
import 'package:qr_scanner/history/history_page.dart';
import 'package:qr_scanner/l10n/generated/app_localizations.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/caju_icons.dart';
import 'package:qr_scanner/theme/caju_qr.dart';
import 'package:qr_scanner/theme/caju_style.dart';
import 'package:qr_scanner/theme/theme_controller.dart';
import 'package:qr_scanner/utils/content_parser.dart';
import 'package:share_plus/share_plus.dart';

enum _GenerateKind { text, url, wifi, phone, email }

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final _contentController = TextEditingController();
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  final _qrKey = GlobalKey();
  _GenerateKind _kind = _GenerateKind.text;
  String _wifiType = 'WPA';
  String? _lastSavedPayload;
  late final Listenable _inputs = Listenable.merge([
    _contentController,
    _ssidController,
    _passwordController,
  ]);

  @override
  void dispose() {
    _contentController.dispose();
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _payload {
    switch (_kind) {
      case _GenerateKind.text:
        return _contentController.text.trim();
      case _GenerateKind.url:
        final text = _contentController.text.trim();
        if (text.isEmpty) return '';
        if (text.contains('://')) return text;
        return 'https://$text';
      case _GenerateKind.phone:
        final phone = _contentController.text.trim();
        return phone.isEmpty ? '' : 'tel:$phone';
      case _GenerateKind.email:
        final email = _contentController.text.trim();
        return email.isEmpty ? '' : 'mailto:$email';
      case _GenerateKind.wifi:
        final ssid = _ssidController.text.trim();
        if (ssid.isEmpty) return '';
        return wifiPayload(
          ssid: ssid,
          password: _passwordController.text,
          encryption: _wifiType,
        );
    }
  }

  Future<void> _saveGeneratedIfNeeded() async {
    final payload = _payload;
    if (payload.isEmpty || payload == _lastSavedPayload) return;
    final parsed = parseContent(payload, hintedType: _kind.name);
    await DatabaseHelper.instance.insertRecord(
      ScanRecord(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        rawValue: payload,
        format: 'qrCode',
        contentType: parsed.contentType,
        source: RecordSource.generate,
      ),
    );
    _lastSavedPayload = payload;
  }

  Future<void> _shareQr() async {
    final l10n = AppLocalizations.of(context)!;
    if (_payload.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.enterContent)));
      return;
    }
    await _saveGeneratedIfNeeded();
    final boundary =
        _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;
    final image = await boundary.toImage(pixelRatio: 3);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) return;
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            bytes.buffer.asUint8List(),
            mimeType: 'image/png',
            name: 'qr-code.png',
          ),
        ],
        fileNameOverrides: ['qr-code.png'],
      ),
    );
  }

  String get _caption {
    if (_kind == _GenerateKind.wifi) {
      return _ssidController.text.trim();
    }
    return _contentController.text.trim();
  }

  Future<void> _openInput() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      barrierColor: Colors.black.withValues(alpha: 0.2),
      builder: (context) => _GenerateInputSheet(
        kind: _kind,
        contentController: _contentController,
        ssidController: _ssidController,
        passwordController: _passwordController,
        wifiType: _wifiType,
        onWifiTypeChanged: (value) {
          setState(() => _wifiType = value);
        },
      ),
    );
    await _saveGeneratedIfNeeded();
  }

  void _selectKind(_GenerateKind kind) {
    setState(() => _kind = kind);
    _openInput();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CajuWash(
      child: SafeArea(
        child: ListenableBuilder(
          listenable: _inputs,
          builder: (context, _) {
            final payload = _payload;
            final caption = _caption;
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Column(
                children: [
                  CajuPageTitle(
                    title: l10n.generateTab,
                    leading: IconButton(
                      onPressed: payload.isEmpty ? null : _shareQr,
                      icon: CajuAnimeIcon(
                        kind: CajuIconKind.share,
                        size: 26,
                        dimmed: payload.isEmpty,
                      ),
                      tooltip: l10n.saveShareQr,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 40,
                        height: 40,
                      ),
                    ),
                    trailing: const HistoryEntryButton(
                      source: RecordSource.generate,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _AtelierPlate(
                      qrKey: _qrKey,
                      payload: payload,
                      caption: caption,
                      emptyHint: l10n.enterContent,
                      onEdit: _openInput,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _KindRail(
                    selected: _kind,
                    onSelect: _selectKind,
                    items: [
                      (l10n.typeText, _GenerateKind.text, CajuIconKind.typeText),
                      (l10n.typeUrl, _GenerateKind.url, CajuIconKind.typeUrl),
                      (l10n.typeWifi, _GenerateKind.wifi, CajuIconKind.typeWifi),
                      (l10n.typePhone, _GenerateKind.phone, CajuIconKind.typePhone),
                      (l10n.typeEmail, _GenerateKind.email, CajuIconKind.typeEmail),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AtelierPlate extends StatelessWidget {
  const _AtelierPlate({
    required this.qrKey,
    required this.payload,
    required this.caption,
    required this.emptyHint,
    required this.onEdit,
  });

  final GlobalKey qrKey;
  final String payload;
  final String caption;
  final String emptyHint;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ready = payload.isNotEmpty;
    final business =
        ThemeScope.of(context).iconStyle == AppIconStyle.business;
    final plateRadius = business ? 0.0 : 18.0;
    final plateColor =
        business ? CajuQrView.paper : const Color(0xFFFFF6E8);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!ready) {
          return _GhostPrint(hint: emptyHint, onEdit: onEdit);
        }
        final side = cajuStageSide(constraints);
        return Column(
          children: [
            const Expanded(child: SizedBox.shrink()),
            SizedBox(
              width: side,
              height: side,
              child: CustomPaint(
                painter: _CropMarkPainter(
                  color: business
                      ? CajuQrView.graphite.withValues(alpha: 0.7)
                      : colorScheme.primary,
                  sharp: false,
                  sketch: business,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Material(
                    color: plateColor,
                    borderRadius: BorderRadius.circular(plateRadius),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: onEdit,
                      borderRadius: BorderRadius.circular(plateRadius),
                      child: Center(
                        child: RepaintBoundary(
                          key: qrKey,
                          child: CajuQrView(
                            data: payload,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: caption.isEmpty
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: SizedBox(
                          width: side,
                          child: GestureDetector(
                            onTap: onEdit,
                            child: Text(
                              caption,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: cajuCenterHintStyle(
                                context,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
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

class _GhostPrint extends StatelessWidget {
  const _GhostPrint({required this.hint, required this.onEdit});

  final String hint;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final illustration =
        ThemeScope.of(context).iconStyle == AppIconStyle.business
            ? const CajuSketch(size: cajuEmptyMarkSize)
            : const Opacity(
                opacity: 0.9,
                child: CajuLogoBadge(size: cajuEmptyMarkSize),
              );
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onEdit,
        child: Column(
          children: [
            const Expanded(child: SizedBox.shrink()),
            illustration,
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 12, 28, 0),
                  child: Text(
                    hint,
                    textAlign: TextAlign.center,
                    style: cajuCenterHintStyle(
                      context,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KindRail extends StatelessWidget {
  const _KindRail({
    required this.selected,
    required this.onSelect,
    required this.items,
  });

  final _GenerateKind selected;
  final ValueChanged<_GenerateKind> onSelect;
  final List<(String, _GenerateKind, CajuIconKind)> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _KindStamp(
              label: items[i].$1,
              icon: items[i].$3,
              selected: selected == items[i].$2,
              onTap: () => onSelect(items[i].$2),
            ),
          ),
        ],
      ],
    );
  }
}

class _KindStamp extends StatelessWidget {
  const _KindStamp({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.iconSize = 26,
    this.gray = false,
  });

  final String label;
  final CajuIconKind icon;
  final double iconSize;
  final bool selected;
  final bool gray;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CajuStampButton(
      label: label,
      selected: selected,
      onTap: onTap,
      icon: gray
          ? _GrayedCajuIcon(kind: icon, size: iconSize)
          : CajuAnimeIcon(kind: icon, size: iconSize),
    );
  }
}

class _GenerateInputSheet extends StatefulWidget {
  const _GenerateInputSheet({
    required this.kind,
    required this.contentController,
    required this.ssidController,
    required this.passwordController,
    required this.wifiType,
    required this.onWifiTypeChanged,
  });

  final _GenerateKind kind;
  final TextEditingController contentController;
  final TextEditingController ssidController;
  final TextEditingController passwordController;
  final String wifiType;
  final ValueChanged<String> onWifiTypeChanged;

  @override
  State<_GenerateInputSheet> createState() => _GenerateInputSheetState();
}

class _GenerateInputSheetState extends State<_GenerateInputSheet> {
  late String _wifiType = widget.wifiType;

  @override
  Widget build(BuildContext context) {
    final kind = widget.kind;
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final title = switch (kind) {
      _GenerateKind.text => l10n.typeText,
      _GenerateKind.url => l10n.typeUrl,
      _GenerateKind.wifi => l10n.typeWifi,
      _GenerateKind.phone => l10n.typePhone,
      _GenerateKind.email => l10n.typeEmail,
    };
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + inset),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.primary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 18),
                if (kind == _GenerateKind.wifi)
                  _WifiCaption(
                    ssidController: widget.ssidController,
                    passwordController: widget.passwordController,
                    wifiType: _wifiType,
                    onTypeChanged: (value) {
                      setState(() => _wifiType = value);
                      widget.onWifiTypeChanged(value);
                    },
                    onChanged: () {},
                    l10n: l10n,
                    autofocus: true,
                  )
                else
                  TextField(
                    controller: widget.contentController,
                    autofocus: true,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: switch (kind) {
                      _GenerateKind.url => TextInputType.url,
                      _GenerateKind.phone => TextInputType.phone,
                      _GenerateKind.email => TextInputType.emailAddress,
                      _ => TextInputType.text,
                    },
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => Navigator.of(context).pop(),
                    decoration: InputDecoration(
                      hintText: l10n.inputHint,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CajuAnimeIcon(
                          kind: switch (kind) {
                            _GenerateKind.url => CajuIconKind.typeUrl,
                            _GenerateKind.phone => CajuIconKind.typePhone,
                            _GenerateKind.email => CajuIconKind.typeEmail,
                            _ => CajuIconKind.typeText,
                          },
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.ok),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GrayedCajuIcon extends StatelessWidget {
  const _GrayedCajuIcon({required this.kind, required this.size});

  final CajuIconKind kind;
  final double size;

  static const _gray = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 0.55, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: RepaintBoundary(
        child: ColorFiltered(
          colorFilter: _gray,
          child: CajuAnimeIcon(kind: kind, size: size),
        ),
      ),
    );
  }
}

class _WifiCaption extends StatelessWidget {
  const _WifiCaption({
    required this.ssidController,
    required this.passwordController,
    required this.wifiType,
    required this.onTypeChanged,
    required this.onChanged,
    required this.l10n,
    this.autofocus = false,
  });

  final TextEditingController ssidController;
  final TextEditingController passwordController;
  final String wifiType;
  final ValueChanged<String> onTypeChanged;
  final VoidCallback onChanged;
  final AppLocalizations l10n;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: ssidController,
          autofocus: autofocus,
          onChanged: (_) => onChanged(),
          decoration: InputDecoration(
            labelText: l10n.wifiSsid,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(10),
              child: CajuAnimeIcon(kind: CajuIconKind.typeWifi, size: 24),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (final item in [
              ('WPA', l10n.wpa, CajuIconKind.wifiLock, false),
              ('WEP', l10n.wep, CajuIconKind.wifiShield, false),
              ('nopass', l10n.nopass, CajuIconKind.wifiLock, true),
            ]) ...[
              if (item.$1 != 'WPA') const SizedBox(width: 8),
              Expanded(
                child: _KindStamp(
                  label: item.$2,
                  icon: item.$3,
                  gray: item.$4,
                  selected: wifiType == item.$1,
                  onTap: () => onTypeChanged(item.$1),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          controller: passwordController,
          enabled: wifiType != 'nopass',
          onChanged: (_) => onChanged(),
          decoration: InputDecoration(
            labelText: l10n.wifiPassword,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: wifiType == 'nopass'
                  ? const _GrayedCajuIcon(
                      kind: CajuIconKind.wifiLock,
                      size: 24,
                    )
                  : const CajuAnimeIcon(
                      kind: CajuIconKind.wifiLock,
                      size: 24,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CropMarkPainter extends CustomPainter {
  const _CropMarkPainter({
    required this.color,
    this.sharp = false,
    this.sketch = false,
  });

  final Color color;
  final bool sharp;
  final bool sketch;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final paint = Paint()
      ..color = color.withValues(alpha: sketch ? 0.7 : 0.55)
      ..strokeWidth = sketch ? 1.15 : 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    const arm = 22.0;
    const inset = 8.0;
    final radius = sharp ? 0.0 : 18.0;
    final w = size.width;
    final h = size.height;

    void corner(double x, double y, double sx, double sy) {
      final path = Path()..moveTo(x + sx * arm, y);
      if (sharp) {
        path
          ..lineTo(x, y)
          ..lineTo(x, y + sy * arm);
      } else {
        path
          ..lineTo(x + sx * radius, y)
          ..arcToPoint(
            Offset(x, y + sy * radius),
            radius: Radius.circular(radius),
            clockwise: sx * sy < 0,
          )
          ..lineTo(x, y + sy * arm);
      }
      canvas.drawPath(path, paint);
      if (sketch) {
        final echo = Paint()
          ..color = color.withValues(alpha: 0.22)
          ..strokeWidth = 0.7
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
        canvas.save();
        canvas.translate(sx * 0.8, sy * 0.6);
        canvas.drawPath(path, echo);
        canvas.restore();
      }
    }

    corner(inset, inset, 1, 1);
    corner(w - inset, inset, -1, 1);
    corner(inset, h - inset, 1, -1);
    corner(w - inset, h - inset, -1, -1);

    final mid = Paint()
      ..color = color.withValues(alpha: sketch ? 0.28 : 0.22)
      ..strokeWidth = sketch ? 0.8 : 1
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w / 2, 4), Offset(w / 2, 11), mid);
    canvas.drawLine(Offset(w / 2, h - 11), Offset(w / 2, h - 4), mid);
  }

  @override
  bool shouldRepaint(covariant _CropMarkPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.sharp != sharp ||
        oldDelegate.sketch != sketch;
  }
}

