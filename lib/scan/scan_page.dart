import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/database/database_helper.dart';
import 'package:qr_scanner/database/scan_record.dart';
import 'package:qr_scanner/l10n/generated/app_localizations.dart';
import 'package:qr_scanner/history/history_page.dart';
import 'package:qr_scanner/scan/lift_detector.dart';
import 'package:qr_scanner/scan/result_sheet.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/caju_icons.dart';
import 'package:qr_scanner/theme/caju_qr.dart';
import 'package:qr_scanner/theme/caju_style.dart';
import 'package:qr_scanner/theme/theme_controller.dart';
import 'package:qr_scanner/utils/content_parser.dart';
import 'package:qr_scanner/utils/image_decoder.dart';
import 'package:qr_scanner/utils/platform_support.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key, required this.active});

  final bool active;

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  MobileScannerController? _controller;
  bool _handling = false;
  bool _readingImage = false;
  String? _lastValue;
  DateTime? _lastTime;
  final _stageKey = GlobalKey();
  Rect? _stageRect;
  bool _cameraError = false;
  bool _permissionDenied = false;
  String? _cameraErrorDetail;
  final LiftDetector _lift = LiftDetector();
  bool _motionHolding = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lift.addListener(_onMotionChanged);
    if (supportsLiveScan) {
      _controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
      );
      if (widget.active) {
        _lift.start();
      }
    }
  }

  @override
  void didUpdateWidget(covariant ScanPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active == widget.active) return;
    if (widget.active && supportsLiveScan) {
      _lift.start();
    } else {
      _lift.stop();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lift.stop();
    } else if (state == AppLifecycleState.resumed &&
        widget.active &&
        supportsLiveScan) {
      _lift.start();
    }
  }

  void _onMotionChanged() {
    if (!mounted) return;
    setState(() => _motionHolding = _lift.state == HoldingState.holding);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lift.removeListener(_onMotionChanged);
    _lift.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handling) return;
    final barcode = capture.barcodes.where((item) {
      return item.rawValue != null && item.rawValue!.trim().isNotEmpty;
    }).firstOrNull;
    if (barcode?.rawValue == null) return;

    final value = barcode!.rawValue!.trim();
    final now = DateTime.now();
    if (value == _lastValue &&
        _lastTime != null &&
        now.difference(_lastTime!) < const Duration(seconds: 2)) {
      return;
    }
    _lastValue = value;
    _lastTime = now;
    await _handleDecoded(
      DecodedCode(
        rawValue: value,
        format: barcode.format.name,
        hintedType: barcode.type.name,
      ),
    );
  }

  Future<void> _handleDecoded(DecodedCode decoded) async {
    if (_handling || !mounted) return;
    _handling = true;
    HapticFeedback.mediumImpact();
    await _controller?.stop();

    final parsed = parseContent(
      decoded.rawValue,
      hintedType: decoded.hintedType,
    );
    final record = ScanRecord(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      rawValue: decoded.rawValue,
      format: decoded.format,
      contentType: parsed.contentType,
    );

    try {
      final id = await DatabaseHelper.instance.insertRecord(record);
      if (!mounted) return;
      await showScanResultSheet(context, record.copyWith(id: id));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted && _cameraShouldRun) {
        try {
          await _controller?.start();
        } catch (_) {}
      }
      _handling = false;
    }
  }

  Future<void> _pickImage() async {
    if (_readingImage) return;
    setState(() => _readingImage = true);
    final l10n = AppLocalizations.of(context)!;
    try {
      final file = await _selectImage();
      if (file == null) return;
      final decoded = await decodeFromXFile(file);
      if (!mounted) return;
      if (decoded == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.noCodeFound)));
        return;
      }
      await _handleDecoded(decoded);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.pickImageFailed)));
    } finally {
      if (mounted) setState(() => _readingImage = false);
    }
  }

  Future<XFile?> _selectImage() async {
    try {
      return await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (_) {
      final file = await FilePicker.pickFile(type: FileType.image);
      return file?.xFile;
    }
  }

  Future<void> _openHistory() async {
    await _controller?.stop();
    if (!mounted) return;
    await openHistoryPage(context);
    if (!mounted || !_cameraShouldRun) return;
    try {
      await _controller?.start();
    } catch (_) {}
  }

  void _syncStageRect() {
    if (!mounted) return;
    final stage = _stageKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay = context.findRenderObject() as RenderBox?;
    if (stage == null || overlay == null || !stage.hasSize) return;
    final origin = overlay.globalToLocal(stage.localToGlobal(Offset.zero));
    final rect = origin & stage.size;
    if (_stageRect == rect) return;
    setState(() => _stageRect = rect);
  }

  bool get _cameraShouldRun =>
      widget.active && supportsLiveScan && _motionHolding && !_cameraError;

  bool get _previewOpen => _cameraShouldRun && _controller != null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncStageRect());

    return Stack(
      fit: StackFit.expand,
      children: [
        if (_previewOpen)
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error) {
              final denied =
                  error.errorCode == MobileScannerErrorCode.permissionDenied;
              final detail = error.errorDetails?.message ?? error.toString();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                if (_cameraError &&
                    _permissionDenied == denied &&
                    _cameraErrorDetail == detail) {
                  return;
                }
                setState(() {
                  _cameraError = true;
                  _permissionDenied = denied;
                  _cameraErrorDetail = detail;
                });
              });
              return const CajuWash();
            },
          )
        else
          ColoredBox(
            color: colorScheme.surface,
            child: const CajuWash(),
          ),
        if (_previewOpen)
          Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipPath(
                    clipper: _ViewfinderHoleClipper(
                      rect: _stageRect ?? Rect.zero,
                    ),
                    child: ColoredBox(
                      color: colorScheme.surface,
                      child: const CajuWash(),
                    ),
                  ),
                  CustomPaint(
                    painter: _ViewfinderPainter(
                      rect: _stageRect ?? Rect.zero,
                      accent: CajuThemeExtras.of(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Column(
              children: [
                CajuPageTitle(
                  title: l10n.scanTab,
                  trailing: IconButton(
                    onPressed: _openHistory,
                    icon: const CajuAnimeIcon(
                      kind: CajuIconKind.history,
                      size: 26,
                    ),
                    tooltip: l10n.historyTab,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (!_previewOpen) {
                        final String? message;
                        if (!supportsLiveScan) {
                          message = l10n.liveScanUnsupported;
                        } else if (_cameraError) {
                          message = _permissionDenied
                              ? l10n.cameraPermissionDenied
                              : l10n.cameraError(_cameraErrorDetail ?? '');
                        } else if (!_motionHolding) {
                          message = l10n.scanPickUpPhone;
                        } else {
                          message = null;
                        }
                        return _PreviewClosedPlate(message: message);
                      }
                      final side = cajuStageSide(constraints);
                      return Center(
                        child: SizedBox(
                          key: _stageKey,
                          width: side,
                          height: side,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CajuCenterHint(
                              text: l10n.scanningHint,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    const SizedBox(width: 8),
                    Expanded(
                      child: !_previewOpen
                          ? const SizedBox.shrink()
                          : ValueListenableBuilder(
                              valueListenable: _controller!,
                              builder: (context, state, _) {
                                final torch = state.torchState;
                                final on = torch == TorchState.on;
                                return CajuStampButton(
                                  selected: on,
                                  tooltip: on ? l10n.torchOff : l10n.torchOn,
                                  label: l10n.actionTorch,
                                  onTap: torch == TorchState.unavailable
                                      ? null
                                      : () => _controller?.toggleTorch(),
                                  icon: CajuAnimeIcon(
                                    kind: on
                                        ? CajuIconKind.torchOn
                                        : CajuIconKind.torchOff,
                                    size: 26,
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CajuStampButton(
                        tooltip: l10n.scanFromImage,
                        label: l10n.actionAlbum,
                        onTap: _readingImage ? null : _pickImage,
                        icon: const CajuAnimeIcon(
                          kind: CajuIconKind.gallery,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: !_previewOpen
                          ? const SizedBox.shrink()
                          : CajuStampButton(
                              tooltip: l10n.switchCamera,
                              label: l10n.actionFlip,
                              onTap: () => _controller?.switchCamera(),
                              icon: const CajuAnimeIcon(
                                kind: CajuIconKind.cameraSwitch,
                                size: 26,
                              ),
                            ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_readingImage)
          ColoredBox(
            color: colorScheme.scrim.withValues(alpha: 0.45),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    l10n.imageScanning,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

}

class _PreviewClosedPlate extends StatelessWidget {
  const _PreviewClosedPlate({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final business =
        ThemeScope.of(context).iconStyle == AppIconStyle.business;
    final mark = business
        ? const CajuSketch(size: cajuEmptyMarkSize)
        : const Opacity(
            opacity: 0.9,
            child: CajuLogoBadge(size: cajuEmptyMarkSize),
          );
    return Column(
      children: [
        const Expanded(child: SizedBox.shrink()),
        mark,
        Expanded(
          child: message == null
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 12, 28, 0),
                    child: Text(
                      message!,
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
    );
  }
}

class _ViewfinderHoleClipper extends CustomClipper<Path> {
  const _ViewfinderHoleClipper({required this.rect});

  final Rect rect;

  static const _radius = 20.0;

  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Offset.zero & size);
    if (!rect.isEmpty) {
      path
        ..addRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(_radius)),
        )
        ..fillType = PathFillType.evenOdd;
    }
    return path;
  }

  @override
  bool shouldReclip(covariant _ViewfinderHoleClipper oldClipper) {
    return oldClipper.rect != rect;
  }
}

class _ViewfinderPainter extends CustomPainter {
  const _ViewfinderPainter({
    required this.rect,
    required this.accent,
  });

  final Rect rect;
  final Color accent;

  static const _radius = 20.0;
  static const _arm = 28.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (rect.isEmpty) return;

    final paint = Paint()
      ..color = accent
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    _corner(canvas, paint, rect.left, rect.top, 1, 1);
    _corner(canvas, paint, rect.right, rect.top, -1, 1);
    _corner(canvas, paint, rect.left, rect.bottom, 1, -1);
    _corner(canvas, paint, rect.right, rect.bottom, -1, -1);
  }

  void _corner(
    Canvas canvas,
    Paint paint,
    double x,
    double y,
    double sx,
    double sy,
  ) {
    final path = Path()
      ..moveTo(x + sx * _arm, y)
      ..lineTo(x + sx * _radius, y)
      ..arcToPoint(
        Offset(x, y + sy * _radius),
        radius: const Radius.circular(_radius),
        clockwise: sx * sy < 0,
      )
      ..lineTo(x, y + sy * _arm);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ViewfinderPainter oldDelegate) {
    return oldDelegate.rect != rect || oldDelegate.accent != accent;
  }
}
