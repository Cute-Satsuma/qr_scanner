import 'package:flutter/material.dart';
import 'package:qr_scanner/l10n/generated/app_localizations.dart';
import 'package:qr_scanner/theme/app_palette.dart';
import 'package:qr_scanner/theme/caju_fonts.dart';
import 'package:qr_scanner/theme/caju_qr.dart';
import 'package:qr_scanner/theme/theme_controller.dart';

class ThemeSettingsPanel extends StatelessWidget {
  const ThemeSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = ThemeScope.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.themeTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.primary,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 16),
                _ThemeSectionTitle(l10n.themeAppearance),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 400;
                    return SegmentedButton<AppBrightnessMode>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: AppBrightnessMode.system,
                          label: Text(l10n.themeSystem),
                          icon: compact
                              ? null
                              : const Icon(
                                  Icons.brightness_auto_outlined,
                                  size: 18,
                                ),
                        ),
                        ButtonSegment(
                          value: AppBrightnessMode.light,
                          label: Text(l10n.themeLight),
                          icon: compact
                              ? null
                              : const Icon(Icons.light_mode_outlined, size: 18),
                        ),
                        ButtonSegment(
                          value: AppBrightnessMode.dark,
                          label: Text(l10n.themeDark),
                          icon: compact
                              ? null
                              : const Icon(Icons.dark_mode_outlined, size: 18),
                        ),
                      ],
                      selected: {controller.brightnessMode},
                      onSelectionChanged: (value) {
                        controller.setBrightnessMode(value.first);
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                _ThemeSectionTitle(l10n.themeColor),
                const SizedBox(height: 12),
                _PaletteRow(
                  palettes: const [
                    AppPalette.orange,
                    AppPalette.green,
                    AppPalette.teal,
                  ],
                  selected: controller.palette,
                  l10n: l10n,
                  onSelect: controller.setPalette,
                ),
                const SizedBox(height: 8),
                _PaletteRow(
                  palettes: const [
                    AppPalette.blue,
                    AppPalette.slate,
                    AppPalette.paper,
                  ],
                  selected: controller.palette,
                  l10n: l10n,
                  onSelect: controller.setPalette,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: _ThemeSectionTitle(l10n.themePaperFilter)),
                    Switch(
                      value: controller.paperFilter,
                      onChanged: controller.setPaperFilter,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _ThemeSectionTitle(l10n.themePaperGrain),
                ValueListenableBuilder<double>(
                  valueListenable: controller.paperGrain,
                  builder: (context, grain, _) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 2),
                      child: _RoughnessSlider(
                        value: grain,
                        enabled: controller.paperFilter,
                        onChanged: controller.setPaperGrain,
                        onChangeEnd: (value) => controller.setPaperGrain(
                          value,
                          persist: true,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _ThemeSectionTitle(l10n.themeFont),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final face in AppTypeface.values)
                      ChoiceChip(
                        showCheckmark: false,
                        label: Text(
                          _fontLabel(l10n, face),
                          style: cutePreviewStyle(
                            face,
                            Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        selected: controller.typeface == face,
                        onSelected: (_) => controller.setTypeface(face),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                _ThemeSectionTitle(l10n.themeIconStyle),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _IconStyleChoice(
                        style: AppIconStyle.anime,
                        label: l10n.iconStyleAnime,
                        selected: controller.iconStyle == AppIconStyle.anime,
                        onTap: () => controller.setIconStyle(AppIconStyle.anime),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _IconStyleChoice(
                        style: AppIconStyle.business,
                        label: l10n.iconStyleBusiness,
                        selected: controller.iconStyle == AppIconStyle.business,
                        onTap: () =>
                            controller.setIconStyle(AppIconStyle.business),
                      ),
                    ),
                  ],
                ),
          ],
        );
      },
    );
  }

  static String _paletteLabel(AppLocalizations l10n, AppPalette palette) {
    switch (palette) {
      case AppPalette.orange:
        return l10n.themeOrange;
      case AppPalette.green:
        return l10n.themeGreen;
      case AppPalette.teal:
        return l10n.themeTeal;
      case AppPalette.blue:
        return l10n.themeBlue;
      case AppPalette.slate:
        return l10n.themeSlate;
      case AppPalette.paper:
        return l10n.themePaper;
    }
  }

  static String _fontLabel(AppLocalizations l10n, AppTypeface typeface) {
    switch (typeface) {
      case AppTypeface.rounded:
        return l10n.fontRounded;
      case AppTypeface.maru:
        return l10n.fontMaru;
      case AppTypeface.xiaowei:
        return l10n.fontXiaoWei;
      case AppTypeface.nunito:
        return l10n.fontNunito;
      case AppTypeface.system:
        return l10n.fontSystem;
    }
  }
}

class _ThemeSectionTitle extends StatelessWidget {
  const _ThemeSectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        letterSpacing: 1.2,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

const _roughnessStops = [0.0, 0.25, 0.50, 0.75, 1.0];
const _roughnessTickDots = [0.25, 0.50, 0.75];
const _roughnessTrackPad = EdgeInsets.symmetric(horizontal: 12);
const _roughnessThumbRadius = 7.0;

double _nearestRoughnessStop(double value) {
  var best = _roughnessStops.first;
  var bestDist = (value - best).abs();
  for (final stop in _roughnessStops.skip(1)) {
    final dist = (value - stop).abs();
    if (dist < bestDist) {
      best = stop;
      bestDist = dist;
    }
  }
  return best;
}

class _RoughnessSlider extends StatefulWidget {
  const _RoughnessSlider({
    required this.value,
    required this.enabled,
    required this.onChanged,
    required this.onChangeEnd,
  });

  final double value;
  final bool enabled;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  @override
  State<_RoughnessSlider> createState() => _RoughnessSliderState();
}

class _RoughnessSliderState extends State<_RoughnessSlider> {
  var _updates = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final active = widget.enabled
        ? colorScheme.primary
        : colorScheme.onSurface.withValues(alpha: 0.28);
    final inactive = widget.enabled
        ? colorScheme.primary.withValues(alpha: 0.28)
        : colorScheme.onSurface.withValues(alpha: 0.12);
    final tickActive = Color.alphaBlend(active, colorScheme.surface);
    final tickInactive = Color.alphaBlend(inactive, colorScheme.surface);
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        padding: _roughnessTrackPad,
        year2023: true,
        trackHeight: _RoughnessTrackPainter.trackHeight,
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        disabledActiveTrackColor: Colors.transparent,
        disabledInactiveTrackColor: Colors.transparent,
        overlayShape: SliderComponentShape.noOverlay,
        thumbColor: active,
        disabledThumbColor: active,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: _roughnessThumbRadius,
          disabledThumbRadius: _roughnessThumbRadius,
        ),
      ),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Padding(
                padding: _roughnessTrackPad,
                child: CustomPaint(
                  painter: _RoughnessTrackPainter(
                    value: widget.value,
                    active: active,
                    inactive: inactive,
                    tickActive: tickActive,
                    tickInactive: tickInactive,
                  ),
                ),
              ),
            ),
            Slider(
              value: widget.value,
              onChanged: widget.enabled
                  ? (value) {
                      _updates += 1;
                      widget.onChanged(value);
                    }
                  : null,
              onChangeStart: widget.enabled
                  ? (_) {
                      _updates = 0;
                    }
                  : null,
              onChangeEnd: widget.enabled
                  ? (value) {
                      final next = _updates <= 1
                          ? _nearestRoughnessStop(value)
                          : value;
                      widget.onChangeEnd(next);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoughnessTrackPainter extends CustomPainter {
  const _RoughnessTrackPainter({
    required this.value,
    required this.active,
    required this.inactive,
    required this.tickActive,
    required this.tickInactive,
  });

  final double value;
  final Color active;
  final Color inactive;
  final Color tickActive;
  final Color tickInactive;

  static const trackHeight = 5.0;

  void _paintTrack(Canvas canvas, Size size, Color color) {
    final y = size.height / 2;
    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        y - trackHeight / 2,
        size.width,
        y + trackHeight / 2,
        const Radius.circular(trackHeight / 2),
      ),
      Paint()..color = color,
    );
  }

  void _paintTicks(Canvas canvas, Size size, Color color) {
    final y = size.height / 2;
    final paint = Paint()..color = color;
    for (final stop in _roughnessTickDots) {
      canvas.drawCircle(
        Offset(size.width * stop, y),
        _roughnessThumbRadius,
        paint,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    _paintTrack(canvas, size, inactive);
    _paintTicks(canvas, size, tickInactive);
    final filledWidth = (size.width * value.clamp(0.0, 1.0)).clamp(
      0.0,
      size.width,
    );
    if (filledWidth <= 0) return;
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, filledWidth, size.height));
    _paintTrack(canvas, size, active);
    _paintTicks(canvas, size, tickActive);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RoughnessTrackPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.active != active ||
        oldDelegate.inactive != inactive ||
        oldDelegate.tickActive != tickActive ||
        oldDelegate.tickInactive != tickInactive;
  }
}

class _IconStyleChoice extends StatelessWidget {
  const _IconStyleChoice({
    required this.style,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final AppIconStyle style;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  style == AppIconStyle.business ? 0 : 16,
                ),
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
              clipBehavior: Clip.antiAlias,
              child: IgnorePointer(
                child: CajuQrView(
                  data: 'Caju',
                  size: 72,
                  style: style,
                ),
              ),
            ),
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
  }
}

class _PaletteRow extends StatelessWidget {
  const _PaletteRow({
    required this.palettes,
    required this.selected,
    required this.l10n,
    required this.onSelect,
  });

  final List<AppPalette> palettes;
  final AppPalette selected;
  final AppLocalizations l10n;
  final ValueChanged<AppPalette> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < palettes.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _PaletteChoice(
              palette: palettes[i],
              selected: selected == palettes[i],
              label: ThemeSettingsPanel._paletteLabel(l10n, palettes[i]),
              onTap: () => onSelect(palettes[i]),
            ),
          ),
        ],
      ],
    );
  }
}

class _PaletteChoice extends StatelessWidget {
  const _PaletteChoice({
    required this.palette,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final AppPalette palette;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final spec = paletteSpecs[palette]!;
    final swatch = palette == AppPalette.paper
        ? const Color(0xFFE6D3B0)
        : spec.primary;
    final checkColor = palette == AppPalette.paper
        ? spec.primary
        : Colors.white;
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 36,
              height: 36,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? spec.primary
                      : colorScheme.outline.withValues(alpha: 0.28),
                  width: selected ? 2 : 1,
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: swatch,
                ),
                child: selected
                    ? Icon(Icons.check, size: 16, color: checkColor)
                    : const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: selected
                      ? spec.primary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
